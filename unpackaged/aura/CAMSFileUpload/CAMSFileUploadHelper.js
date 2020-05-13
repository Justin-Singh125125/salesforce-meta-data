({
    MAX_FILE_SIZE: 4500000, /* 6 000 000 * 3/4 to account for base64 */
    CHUNK_SIZE: 950000, /* Use a multiple of 4 */

	save: function (component) 
	{
		console.log('helper.save');
        var fileInput = component.find("file").getElement();
        var file = fileInput.files[0];
		if (file.size > this.MAX_FILE_SIZE) 
		{
			component.set("v.hasErrors",true);
			component.set("v.errors",'File size cannot exceed ' + this.MAX_FILE_SIZE + ' bytes.\n' + 'Selected file size: ' + file.size);
            return;
        }
        var fr = new FileReader();
        var self = this;
		fr.onload = function () 
		{
            var fileContents = fr.result;
            var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
            fileContents = fileContents.substring(dataStart);
            self.upload(component, file, fileContents);
        };
        fr.readAsDataURL(file);
    },
	upload: function (component, file, fileContents) 
	{
		console.log('helper.upload');
        var fromPos = 0;
        var toPos = Math.min(fileContents.length, fromPos + this.CHUNK_SIZE);
        this.uploadChunk(component, file, fileContents, fromPos, toPos, '');
    },
	uploadChunk: function (component, file, fileContents, fromPos, toPos, attachId) 
	{		
		component.set('v.progress', (fromPos/fileContents.length)*100);
		var action = component.get("c.SaveTheChunk");
		var chunk = fileContents.substring(fromPos, toPos);
		action.setParams({parentId: component.get("v.recordId"), fileName: file.name, base64Data: encodeURIComponent(chunk), contentType: file.type, fileId: attachId});
		var self = this;
		action.setCallback(this, function (a) 
		{
			var state = a.getState();
			
            if(state == "SUCCESS")
            {
				console.log('uploadChunk: Callback');
				attachId = a.getReturnValue();
				console.log('attachId: ' + attachId);				
				fromPos = toPos;
				toPos = Math.min(fileContents.length, fromPos + self.CHUNK_SIZE);
				if (fromPos < toPos) 
				{					
					self.uploadChunk(component, file, fileContents, fromPos, toPos, attachId);
				} 
				else 
				{
					component.set("v.uploading", false);
					console.log('uploadChunk: done');
					self.createCAMSFile(component,attachId);
				}
			}
			else if (state == "ERROR") 			
			{			
				component.set("v.uploading", false);
				var errors = a.getError();								
				if (errors) 
				{
                    if (errors[0] && errors[0].message) 
                    {
                        component.set("v.hasErrors",true);
                        component.set("v.errors",errors[0].message);
                        console.log("Error message: " + errors);
                    }
                } 
                else
                {
                    component.set("v.hasErrors",true);
                    component.set("v.errors","Unknown error");
                    console.log("Unknown error");
                }
            }
		});
		$A.getCallback(function ()
		{
			$A.enqueueAction(action);
		})();
    },
	createCAMSFile: function (component,attachId) 
	{
		var action = component.get("c.SaveCAMSFile");
		action.setParams({recordId: component.get("v.recordId"), name: component.get("v.FileName"), description: component.get("v.Document.Description"), fin: component.get("v.final"), contentVersionId: attachId});
		action.setCallback(this, function (a) 
		{
			var returnValue = a.getReturnValue();
            var state = a.getState();
            if(state == "SUCCESS")
            {
				component.set("v.Document.Description", null);
				component.set("v.FileName", null);
				component.set("v.isOpen", false);
				$A.get('e.force:refreshView').fire();
			}
			else if (state == "ERROR") 
            {                
                var errors = a.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) 
                    {
                        component.set("v.hasErrors",true);
                        component.set("v.errors",errors[0].message);
                        console.log("Error message: " + errors);
                    }
                } 
                else
                {
                    component.set("v.hasErrors",true);
                    component.set("v.errors","Unknown error");
                    console.log("Unknown error");
                }
            }
		});
		$A.enqueueAction(action);
    },
})
({
    init: function (cmp, event, helper) 
    {
        cmp.set('v.columns', [
            {label: 'Case', fieldName: 'URL', type: 'url', typeAttributes: {label:  {fieldName: 'CaseNumber'}}},
            {label: 'Subject', fieldName: 'Subject', type: 'string'},
            {label: 'Status', fieldName: 'Status', type: 'string'},
        ]);        
        helper.fetchData(cmp);
    }
})
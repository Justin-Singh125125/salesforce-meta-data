({
    init: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {location: {latitude: 36.7783,longitude: -119.4179}, title: 'The State Capitol'}
        ]);
		cmp.set('v.zoomLevel', 10);
		cmp.set('v.center', {location: {latitude: 36.7783,longitude: -119.4179}});
    }
})
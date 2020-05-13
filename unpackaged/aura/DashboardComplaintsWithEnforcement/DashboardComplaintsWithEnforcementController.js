({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Complaint', fieldName: 'URL', type: 'url', typeAttributes: {label:  {fieldName: 'ComplaintNumber'}}},
            {label: 'Date', fieldName: 'CreatedDate', type: 'datetime'},
        ]);
        helper.fetchData(cmp, 10);
    }
})
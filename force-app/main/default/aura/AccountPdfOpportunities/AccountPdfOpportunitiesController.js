({
	doInit : function(component, event, helper) {
		var pdfData = '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cyA1IDAgUi9UeXBlL1BhZ2UvUmVzb3VyY2VzPDwvUHJvY1NldCBbL1BERiAvVGV4dCAvSW1hZ2VCIC9JbWFnZUMgL0ltYWdlSV0vRm9udDw8L0YxIDIgMCBSL0YyIDQgMCBSPj4vWE9iamVjdDw8L2ltZzAgMyAwIFI+Pj4+L1BhcmVudCA2IDAgUi9NZWRpYUJveFswIDAgNjEyIDc5Ml0+PgplbmRvYmoKMiAwIG9iajw8L1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250L0Jhc2VGb250L0hlbHZldGljYS9FbmNvZGluZy9XaW5BbnNpRW5jb2Rpbmc+PgplbmRvYmoKNCAwIG9iajw8L1N1YnR5cGUvVHlwZTEvVHlwZS9Gb250L0Jhc2VGb250L0hlbHZldGljYS1Cb2xkL0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZz4+CmVuZG9iago2IDAgb2JqPDwvS2lkc1sxIDAgUl0vVHlwZS9QYWdlcy9Db3VudCAxPj4KZW5kb2JqCjcgMCBvYmo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgNiAwIFI+PgplbmRvYmoKOCAwIG9iajw8L01vZERhdGUoRDoyMDIxMDEyMDE1MTIzNlopL0NyZWF0aW9uRGF0ZShEOjIwMjEwMTIwMTUxMjM2WikvUHJvZHVjZXIoaVRleHQgMi4wLjggXChieSBsb3dhZ2llLmNvbVwpKT4+CmVuZG9iagp4cmVmCjAgOQowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDE3ODMgMDAwMDAgbiAKMDAwMDAwMTk3MSAwMDAwMCBuIAowMDAwMDAwMDE1IDAwMDAwIG4gCjAwMDAwMDIwNTggMDAwMDAgbiAKMDAwMDAwMTExMCAwMDAwMCBuIAowMDAwMDAyMTUwIDAwMDAwIG4gCjAwMDAwMDIyMDAgMDAwMDAgbiAKMDAwMDAwMjI0NCAwMDAwMCBuIAp0cmFpbGVyCjw8L0luZm8gOCAwIFIvSUQgWzxlYjhmM2JkOWIyZTJhYWU0ZWYxODMzMTU5NjM1YTA5Yj48MTUyYWUyYTAwODRjOWM1YWU5NmQwYjIyNzk5OWFkZTA+XS9Sb290IDcgMCBSL1NpemUgOT4+CnN0YXJ0eHJlZgoyMzYzCiUlRU9GCg==';
        let data = component.get('c.getHref');
        data.setParams({
            recordId : component.get('v.recordId')
        })
        data.setCallback(this, function(response){
            pdfData = response.getReturnValue();
            let state = response.getState();
            if(state == "SUCCESS"){
                console.log(pdfData);
                
                const binStr = window.atob( + pdfData );
                console.log(binStr);
                const len = binStr.length;
                const arr = new Uint8Array(len);
                for (let i = 0; i < len; i++) {
                    arr[ i ] = binStr.charCodeAt( i );
                }
                const blob = new Blob( [arr], { type: "application/pdf" } );
        		const url = URL.createObjectURL( blob );
                console.log("url:" + url);
                component.set("v.pdfData", url);
            }
        });
        
        $A.enqueueAction(data);
        
        
        $A.createComponent(
            "c:pdfViewer",
            	{
                	"pdfData": pdfData
            	},
            	function(pdfViewer, status, errorMessage){
                                console.log(pdfData);
                	if (status === "SUCCESS") {
                  		var pdfContainer = component.get("v.pdfContainer");
                   		pdfContainer.push(pdfViewer);
                   		component.set("v.pdfContainer", pdfContainer);
                	}
                	else if (status === "INCOMPLETE") {
                    	console.log("No response from server or client is offline.")
                	}
                	else if (status === "ERROR") {
                    	console.log("Error: " + errorMessage);
	                }
       			}
    	);
	
	}
})
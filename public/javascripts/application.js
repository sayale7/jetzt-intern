//js for autocomplete in messaging

validate_email = function(email){
    var regexEmail = /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i
    return regexEmail.test(email);
    
}

function highlightOnLoad(){
    //document.getElementById("search").focus();
    // Get search string
    if (/search\=/.test(window.location.search)) {
        var searchString = getSearchString();
        if (searchString.toString().substring(0, 4) == "post") {
            var elem = document.getElementById(searchString.toString());
			elem.className = 'active_elem';
        }
        else {
        
            // Starting node, parent to all nodes you want to search
            var textContainerNode = document.getElementById("content");
            
            // Informational message for search
            var searchInfo = 'Search Results for: ';
            
            // Split search terms on '|' and iterate over resulting array
            var searchTerms = searchString.split('|');
            //alert(searchTerms);
            for (var i in searchTerms) {
                // The regex is the secret, it prevents text within tag declarations to be affected
                var regex = new RegExp(">([^<]*)?(" + searchTerms[i] + ")([^>]*)?<", "ig");
                highlightTextNodes(textContainerNode, regex, i);
                // Add to info-string
                searchInfo += ' <span class="highlighted">' + searchTerms[i] + '</span> ';
            }
            // term' + i + '
            // Create div describing the search
            var searchTermDiv = document.createElement("H2");
            searchTermDiv.className = 'searchterms';
            searchTermDiv.innerHTML = searchInfo;
            
            // Insert as very first child in searched node
            textContainerNode.insertBefore(searchTermDiv, textContainerNode.childNodes[0]);
        }
        
    }
}

// Pull the search string out of the URL
function getSearchString(){
    // Return sanitized search string if it exists
    var rawSearchString = window.location.search.replace(/[a-zA-Z0-9\?\&\=\%\#]+s\=(\w+)(\&.*)?/, "$1");
    rawSearchString = rawSearchString.replace("?search=", "");
    rawSearchString = rawSearchString.replace("&commit=Suchen", "");
    rawSearchString = rawSearchString.replace("%C3%A4", "ä");
    rawSearchString = rawSearchString.replace("%C3%84", "Ä");
    rawSearchString = rawSearchString.replace("%C3%B6", "ö");
    rawSearchString = rawSearchString.replace("%C3%96", "Ö");
    rawSearchString = rawSearchString.replace("%C3%BC", "ü");
    rawSearchString = rawSearchString.replace("%C3%9C", "Ü");
    rawSearchString = rawSearchString.replace("%C3%9F", "ß");
    // Replace '+' with '|' for regex
    // Also replace '%20' if your cms/blog uses this instead (credit to erlando for adding this)
    return rawSearchString.replace(/\%20|\+/g, "\|");
}

function highlightTextNodes(element, regex, termid){
    var tempinnerHTML = element.innerHTML;
    // Do regex replace
    // Inject span with class of 'highlighted termX' for google style highlighting
    element.innerHTML = tempinnerHTML.replace(regex, '>$1<span class="highlighted">$2</span>$3<');
} // term' + termid + '
function Tastendruck(Evenement){
    if (!Evenement) 
        Evenement = window.event;
    if (Evenement.which) {
        Tastencode = Evenement.which;
    }
    else 
        if (Evenement.keyCode) {
            Tastencode = Evenement.keyCode;
        }
    taste(Tastencode);
}

function taste(Tastencode){
    if (Tastencode == 112) {
        document.getElementById("search").focus();
    }
}

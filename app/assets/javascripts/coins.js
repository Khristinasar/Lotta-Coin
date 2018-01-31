(function($) {
$.extend($.fn, {

prefixString: function(value, length) {
var $this = this;
return this.each(function() {
$(this).text($this.padString(value, $(this).text().length, length) + $(this).text());
});
},

postfixString: function(value, length) {
var $this = this;
return this.each(function() {
$(this).text($(this).text() + $this.padString(value, $(this).text().length, length));
});
},

padString: function(value, minLength, maxLength) {
var newString = "";
for (var x = minLength; x < maxLength; x++) {
newString += value;
}

return newString;
}

});
})(jQuery);

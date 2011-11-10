var tags = "abbr|article|aside|audio|canvas|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|subline|summary|time|video".split("|");
for (var i = 0; i < tags.length; i++) { 
  document.createElement(tags[i]);
}
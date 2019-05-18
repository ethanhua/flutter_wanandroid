class TextUtils{

   static String clean(String str){
     return str
         .replaceAll(RegExp("(<em[^>]*>)|(</em>)"), "")
         .replaceAll(RegExp("\n{2,}"), "\n")
         .replaceAll(RegExp("\s{2,}"), " ")
         .replaceAll("&ndash;", "–")
         .replaceAll("&mdash;", "—")
         .replaceAll("&amp;", "&")
         .replaceAll("&lsquo;", "‘")
         .replaceAll("&rsquo;", "’")
         .replaceAll("&sbquo;", "‚")
         .replaceAll("&ldquo;", "“")
         .replaceAll("&rdquo;", "”")
         .replaceAll("&bdquo;", "„")
         .replaceAll("&permil;", "‰")
         .replaceAll("&lsaquo;", "‹")
         .replaceAll("&rsaquo;", "›")
         .replaceAll("&euro;", "€")
         .replaceAll(RegExp("(<p>)|(</p>)"),"");
   }

}
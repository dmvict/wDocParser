
let _ = require( 'wdocparser' );

/**/

let jsParser = new _.docgen.ParserJsdoc
({
  files
});

jsParser.form();
jsParser.parse();


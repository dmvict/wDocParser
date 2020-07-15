
let _ = require( 'wdocparser' );

/**
 * @description This sample shows how to use the parser
 * @file Sample.s
*/

let jsParser = new _.docgen.ParserJsdoc
({
  inPath : __filename
});

jsParser.form();
let ready = jsParser.parse();

ready.then( ( product ) => 
{
  console.log( _.toJson( product.entities ) )
  return null;
})

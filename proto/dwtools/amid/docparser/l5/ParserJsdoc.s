( function _ParserJsdoc_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  var doctrine = require( 'doctrine' );
}

//

let _ = _global_.wTools;
let Parent = _.docgen.ParserAbstract;
let Self = function wParserJsdoc( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ParserJsdoc';

// --
// routines
// --

function _form()
{
  let self = this;
  _.assert( arguments.length === 0 );

  self.introspector = _.introspector.System
  ({
    defaultParserClass : _.introspector.Parser.JsTreeSitter
  });
}

//

function _parse( filePath )
{
  let self = this;
  
  let sourceCode = self.provider.fileRead({ filePath })
  
  let file = _.introspector.File({ data : sourceCode, sys : self.introspector });
  file.refine();
  
  if( !file.product.byType.gComment )
  return null;
  
  file.product.byType.gComment.each( comment => self._commentHandle( comment, filePath ) );
}

//

function _doctrineParseComment( comment )
{ 
  let self = this;
  let o = 
  { 
    strict : false, 
    recoverable : true,
    sloppy : true 
  }
  let structure = doctrine.parse( doctrine.unwrapComment( comment.text ), o );
  return structure;
}

//

function _entityMake( structure, comment, filePath )
{ 
  let self = this;
  let entity = new _.docgen.EntityJsdoc
  ({
    structure,
    comment : comment.text,
    filePath,
    position : { start : comment.startPosition, end : comment.endPosition }
  });
  entity.form();
  
  return entity;
}

//

function _commentHandle( comment, filePath )
{
  let self = this;
  
  // var t1 = _.time.now();
  let structure = self._doctrineParseComment( comment );
  // self.logger.log( `\nSpent ${_.time.spent( t1 )} for doctrine, file: ${filePath}` )
  
  let entity = self._entityMake( structure, comment, filePath );
  self.product.addEntity( entity );
}

// --
// relations
// --

let Composes =
{
  exts : _.define.own([ 'js', 's', 'ss' ])
}

let Associates =
{
}

let Restricts =
{
  introspector : null
}

let Medials =
{
}

let Statics =
{
}

let Events =
{
}

let Forbids =
{
}

// --
// declare
// --

let Extend =
{

  _form,

  _parse,
  
  _doctrineParseComment,
  _entityMake,
  _commentHandle,

  // relations

  Composes,
  Associates,
  Restricts,
  Medials,
  Statics,
  Events,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();

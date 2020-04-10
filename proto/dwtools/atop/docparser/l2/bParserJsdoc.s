( function _bParserJsdoc_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../IncludeBase.s' );
  require( './aParser.s' )
  
  _.include( 'wIntrospector' );
  
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

function init( o )
{
  let self = this;
  Parent.prototype.init.apply( self,arguments );
}

//

function finit()
{
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function form()
{
  let self = this;
  _.assert( arguments.length === 0 );

  Parent.prototype.form.call( self );

  self.sys = _.introspector.System
  ({ 
    defaultParserClass : _.introspector.Parser.JsTreeSitter 
  });
}

//

function parseAct( filePath )
{
  let self = this;
  
  return self.provider.fileRead({ filePath, sync : 0 })
  .then( sourceCode => 
  {
    let file = _.introspector.File({ data : sourceCode, sys : self.sys });
    file.refine();
    file.product.byType.gComment.each( e =>
    { 
      let parsedComment = doctrine.parse( doctrine.unwrapComment( e.text ), { strict : false, recoverable : true ,sloppy : true } );
      let entity = new _.docgen.EntityJsdoc
      ({
        structure : parsedComment,
        comment : e.text,
        filePath : filePath,
        position : { start : e.startPosition, end : e.endPosition }
      });
      entity.form();
      self.product.addEntity( entity );
    })
    return null;
  })
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
  sys : null
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

  init,
  finit,

  form,

  parseAct,

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
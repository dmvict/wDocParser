( function _Entity_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  require( '../IncludeBase.s' );
}

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wEntity( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Entity';

// --
// routines
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( self );

  if( o )
  self.copy( o );

  _.assert( _.objectIs( self.structure ) );
  _.assert( _.strIs( self.comment ) );
  _.assert( _.strIs( self.filePath ) );
  _.assert( _.objectIs( self.position ) );

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
}

//

function typeGet()
{
  _.assert( 0, 'not implemented' );
}

//

function orphanIs()
{
  _.assert( 0, 'not implemented' );
}

// --
// relations
// --

let Composes =
{
  structure : null,
  comment : null,
  filePath : null,
  position : null,
}

let Associates =
{
}

let Restricts =
{
  tags : _.define.own({}),
  formed : 0,
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

  typeGet,
  orphanIs,

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

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();

( function _EntityJsdoc_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  require( '../IncludeBase.s' );
}

//

let _ = _global_.wTools;
let Parent = _.docgen.Entity;
let Self = function wEntityJsdoc( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'EntityJsdoc';

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
  
  if( self.formed )
  return;

  Parent.prototype.form.call( self );
  
  self._formTags();
  
  self.formed = 1;
}

//

function _formTags()
{ 
  let self = this;
  self.structure.tags.forEach( ( tag ) => 
  { 
    if( self.tags[ tag.title ] )
    {
      self.tags[ tag.title ] = _.arrayAs( self.tags[ tag.title ] );
      self.tags[ tag.title ].push( tag );
    }
    else
    self.tags[ tag.title ] = tag;
  })
}

//

function typeGet()
{
  let self = this;
  
  if( self.tags.function || self.tags.method )
  return 'function';
  
  if( self.tags.class )
  return 'class';
  
  if( self.tags.namespace )
  return 'namespace';
  
  if( self.tags.module )
  return 'module';
  
  return 'entity';
}

//

function orphanIs()
{
  let self = this;
  
  let type = self.typeGet();
  
  if( type === 'module' )
  return false;
  
  if( type === 'namespace' && !self.tags.module )
  return true;
  
  if( type === 'class' && !self.tags.module )
  return true;
  
  if( !self.tags.module && !self.tags.namespace && !self.tags.class )
  return true;
  
  return false;
}

//

// --
// relations
// --

let Composes =
{
}

let Associates =
{
}

let Restricts =
{
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
  _formTags,
  
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

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();
( function _Product_s_()
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wProduct;
function wProduct( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Product';

// --
// implementation
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( self );

  if( o )
  self.copy( o );
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

  self.byType.namespace = [];
  self.byType.module = [];
  self.byType.class = [];

  self.byTypeAndName.namespace = {};
  self.byTypeAndName.module = {};
  self.byTypeAndName.class = {};

  self.byParent.namespace = {};
  self.byParent.module = {};
  self.byParent.class = {};
}

//

function addEntity( entity )
{
  let self = this;
  let entities = _.array.as( entity );
  entities.forEach( ( entity ) =>
  {
    self._addEntity( entity );
  })
}

//

function _addEntity( entity )
{
  let self = this;
  _.assert( entity instanceof _.docgen.EntityJsdoc );

  self.entities.push( entity );

  let type = entity.typeGet();
  if( self.byType[ type ] )
  {
    let name = entity.tags[ type ].name;
    if( !self.byTypeAndName[ type ][ name ] )
    {
      self.byType[ type ].push( entity );
      self.byTypeAndName[ type ][ name ] = entity;
    }
  }

  if( entity.orphanIs() )
  {
    self.orphans.push( entity );
  }
  else if( type !== 'module' )
  {
    if( type === 'namespace' )
    addToByParent( entity, entity.tags.module )
    else if( type === 'class' )
    addToByParent( entity, entity.tags.module )
    else if( entity.tags.class )
    addToByParent( entity, entity.tags.class )
    else if( entity.tags.namespace )
    addToByParent( entity, entity.tags.namespace )
    else if( entity.tags.module )
    addToByParent( entity, entity.tags.module )
  }

  /* */

  function addToByParent( entity, parentTag )
  {
    let parentName = removePrefix( parentTag.name );
    let parenByKind = self.byParent[ parentTag.title ];
    parenByKind[ parentName ] = parenByKind[ parentName ] || []
    parenByKind[ parentName ].push( entity );
  }

  function removePrefix( src )
  {
    let firstIsSmall = /[a-z]/.test( src[ 0 ] );
    let secondIsCapital = /[A-Z]/.test( src[ 1 ] );

    if( firstIsSmall && secondIsCapital )
    return src.slice( 1 );
    return src;
  }
}

// --
// relations
// --

let Composes =
{
  entities : _.define.own([]),
  byType : _.define.own({}),
  byTypeAndName : _.define.own({}),
  byParent : _.define.own({}),
  orphans : _.define.own([]),
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

let Extension =
{

  init,
  finit,

  form,

  addEntity,
  _addEntity,

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
  extend : Extension,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();

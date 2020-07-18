( function _Entity_s_() {

'use strict';

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

  return self._form();
}

//

function typeGet()
{
  let self = this;
  return self._typeGet();
}

//

function orphanIs()
{
  let self = this;
  return self._orphanIs();
}

//

function templateDataMake()
{
  let self = this;
  let type = self.typeGet();

  if( _.objectIs( self.templateData ) )
  return self.templateData;

  let base = EntityPropertiesByType.base;
  let fields = EntityPropertiesByType[ type ];

  _.assert( _.objectIs( fields ) );

  self.templateData = _.mapExtend( null, base, fields );

  self._templateDataMake();

  return self.templateData;
}

//

let BaseEntity =
{
  name : null,
  summary : null,
  description : null,
  kind : null
}

let ModuleEntity =
{
  module : null
}

let NamespaceEntity =
{
  namespace : null,
  module : null
}

let ClassEntity =
{
  class : null,
  namespace : null,
  module : null
}

let FunctionEntity =
{
  params : null,
  examples : null,
  returns : null,
  throws : null,

  class : null,
  namespace : null,
  module : null
}

let TypedefEntity =
{
  properties : null,
  type : null,

  class : null,
  namespace : null,
  module : null
}

let EntityPropertiesByType =
{
  base : BaseEntity,
  module : ModuleEntity,

  namespace : NamespaceEntity,
  class : ClassEntity,
  function : FunctionEntity,
  constructor : FunctionEntity,
  callback : FunctionEntity,
  typedef : TypedefEntity
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
  templateData : null
}

let Associates =
{
}

let Restricts =
{
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

let Extension =
{

  init,
  finit,

  _form : null,
  form,

  _typeGet : null,
  typeGet,

  _orphanIs : null,
  orphanIs,

  _templateDataMake : null,
  templateDataMake,

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

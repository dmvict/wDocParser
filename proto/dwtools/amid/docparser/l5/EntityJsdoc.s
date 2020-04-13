( function _EntityJsdoc_s_() {

'use strict';

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

function _form()
{
  let self = this;
  _.assert( arguments.length === 0 );

  if( self.formed )
  return;
  
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

function _typeGet()
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

function _orphanIs()
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

function _templateDataMake()
{
  let self = this;
  let type = self.typeGet();
  
  _.assert( _.objectIs( self.templateData ) );
  
  let td = self.templateData;
  let tags = self.tags;
  
  let description = self.structure.description;
  
  if( description )
  {
    description = _.strLinesStrip( description );
    let lines = _.strLinesSplit( description );
    td.summary = lines.shift();
    td.description = lines.join('\n');
  }
  if( tags.summary )
  { 
    td.summary = td.summary ? td.summary + '\n' : '';
    td.summary += tags.summary.description; 
  }
  if( tags.description )
  {
    td.description = td.description ? td.description + '\n' : '';
    td.description += tags.description.description; 
  }
  
  if( tags[ type ] )
  td.name = tags[ type ].name,
  td.kind = type;
  
  if( type === 'module' )
  {
    td.module = tags.module.name;
  }
  else if( type === 'namespace' )
  {
    td.namespace = tags.namespace.name;
    td.module = tags.module.name;
  }
  else if( type === 'class' )
  {
    td.class = tags.class.name;
    td.namespace = tags.namespace.name;
    td.module = tags.module.name;
  }
  else
  { 
    
    if( tags.method )
    {
      td.name = tags.method.name;
      td.kind = 'method'
    }
    else if( tags.class && tags.function )
    {
      td.kind = 'method'
    }
    
    //
    
    if( tags.param )
    td.params = _.arrayAs( tags.param ).map( ( e ) => 
    { 
      let param = 
      { 
        name : e.name, 
        description : e.description, 
        type : e.type.name, 
        optional : false
      } 
      
      if( e.default )
      param.default = e.default;
      
      paramTypeMake( param, e )
      
      return param;
    })
    
    //
    
    if( tags.returns )
    { 
      _.assert( _.objectIs( tags.returns ), 'Expects signle return tag' );
      td.returns = 
      { 
        type : tags.returns.type.name, 
        description : tags.returns.description 
      }
      paramTypeMake( td.returns, tags.returns )
    }
    
    //
    
    if( tags.example )
    td.examples = _.arrayAs( tags.example ).map( ( e ) => 
    { 
      return { code : e.description } 
    })
    
    //
    
    if( tags.throws )
    td.throws = _.arrayAs( tags.throws ).map( ( e ) => 
    { 
      let returnDescriptor = { description : e.description } 
      paramTypeMake( returnDescriptor, e )
      return returnDescriptor;
    })
    
    //
    
    if( tags.class )
    td.class = tags.class.name;
    
    if( tags.namespace )
    td.namespace = tags.namespace.name;
    
    if( tags.module )
    td.module = tags.module.name;
  }
  
  _.assert( _.strDefined( self.templateData.name ), `Entity should have name. Source structure:${_.toJs( self.structure)}` )
  
  self.templateData.name = removePrefix( self.templateData.name );
  
  return self.templateData;
  
  /*  */
  
  function paramTypeMake( param, paramTag )
  { 
    let type = paramTag.type;
    
    if( type.type === 'NameExpression' )
    {
      param.type = type.name;
    }
    else if( type.type === 'OptionalType' )
    {
      param.optional = true;
      return paramTypeMake( param, { type : type.expression } );
    }
    else if( type.type === 'UnionType' )
    { 
      param.type = type.elements.map( ( t ) => t.name ).join( '\\|' )
    }
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

  _form,
  _formTags,
  
  _typeGet,
  _orphanIs,
  
  _templateDataMake,

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

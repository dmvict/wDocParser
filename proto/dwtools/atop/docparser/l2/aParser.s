( function _aParser_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  require( '../IncludeBase.s' );
}

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wParserAbstact( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ParserAbstract';

// --
// routines
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !self.logger )
  self.logger = new _.Logger({ output : console });

  if( !self.provider )
  self.provider = _.FileProvider.HardDrive();

  _.workpiece.initFields( self );
  Object.preventExtensions( self );

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
  _.assert( _.strDefined( self.inPath ) || _.objectIs( self.inPath ) );
  _.assert( self.basePath === null || _.strIs( self.basePath ) );
  
  self.product = new _.docgen.Product();
  self.product.form();
}
//

function parse()
{
  let self = this;
  
  self.filesFind();
  
  let cons = [];
  
  self.files.forEach( ( file ) =>
  {
    let con = self.parseAct( file );
    cons.push( con )
  })

  let ready = _.Consequence.AndTake( cons );
  
  ready.then( () => self.product )
  
  return ready;
}

//

function parseAct()
{
  _.assert( 0, 'not implemented' );
}

//

function filesFind()
{ 
  let self = this;
  let fileProvider = self.provider;
  
  self.inPath = fileProvider.recordFilter
  ({ 
    filePath : self.inPath, 
    ends : self.exts 
  });
  self.inPath.form();
  // if( o.basePath === null )
  // o.basePath = o.inPath.basePathSimplest()
  // if( o.basePath === null )
  // o.basePath = path.current();
  // if( o.inPath.prefixPath && path.isRelative( o.inPath.prefixPath ) )
  // o.basePath = path.resolve( o.basePath );
  // o.inPath.basePathUse( o.basePath );
  self.files = fileProvider.filesFind
  ({
    filter : self.inPath,
    mode : 'distinct',
    outputFormat : 'absolute',
    withDirs : false
  });
}

// --
// relations
// --

let Composes =
{
  inPath : null,
  basePath : null,
  verbosity : 1
}

let Associates =
{
  logger : _.define.own( new _.Logger({ output : console }) ),
  provider : null
}

let Restricts =
{
  files : null,
  product : null
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

  parse,
  parseAct,
  
  filesFind,

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
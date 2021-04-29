( function _Parser_s_()
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wParserAbstact;
function wParserAbstact( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ParserAbstract';

// --
// implementation
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
  _.assert( _.strDefined( self.inPath ) || _.object.isBasic( self.inPath ) || _.arrayIs( self.inPath ) );
  _.assert( self.basePath === null || _.strIs( self.basePath ) );

  self.product = new _.docgen.Product();
  self.product.form();

  self._form();
}

//

function parse()
{
  let self = this;

  self.filesFind();

  self.files.forEach( ( file ) =>
  {
    self._parse( file );
  })

  return new _.Consequence().take( self.product )
}

//

function filesFind()
{
  let self = this;
  const fileProvider = self.provider;

  self.inPath = fileProvider.recordFilter
  ({
    filePath : self.inPath,
    ends : self.exts,
    maskAll : { excludeAny : /\.test\./ }
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
  exts : null,
  verbosity : 1,
  inacurate : 0
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

let Extension =
{

  init,
  finit,

  _form : null,
  form,

  _parse : null,
  parse,

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
  extend : Extension,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();

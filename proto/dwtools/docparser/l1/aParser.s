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
  _.assert( _.longIs( self.files ) );

  if( !self.files.length )
  throw _.err( `Option {-files-} of parser ${self.shortName} should contain at least one source file path.` )

}

function parse()
{
  let self = this;
  let result = Object.create( null );
  let files = self.files;
  let cons = [];

  files.forEach( ( file ) =>
  {
    let ready = self.parseAct( file );
    ready.finally( ( err, got ) =>
    {
      if( err )
      _.errLogOnce( err );
      else
      result[ got.file ] = got.data;
    })
    cons.push( ready )
  })

  return _.Consequence.AndTake( cons )
  .then( () => result )
}

//

let parseAct = null;

//

// --
// relations
// --

let Composes =
{
  files : null,
  verbosity : 1
}

let Associates =
{
  logger : _.define.own( new _.Logger({ output : console }) ),
  provider : null
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

  parse,
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

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.docgen[ Self.shortName ] = Self;

})();
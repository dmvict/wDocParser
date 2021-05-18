( function _ParserJsdoc_s_()
{

'use strict';

var doctrine;

if( typeof module !== 'undefined' )
{
  doctrine = require( 'doctrine' );
}

//

const _ = _global_.wTools;
const Parent = _.docgen.ParserAbstract;
const Self = wParserJsdoc;
function wParserJsdoc( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ParserJsdoc';

// --
// implementation
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

let commentRegexp = /\/\*\*\s*\n([^\*]|(\*(?!\/)))*\*\//g

function _parse( filePath )
{
  let self = this;

  let sourceCode = self.provider.fileRead({ filePath })

  if( self.inacurate )
  {
    let comments = sourceCode.match( commentRegexp );
    if( !comments )
    return;

    comments.forEach( ( comment ) =>
    {
      self._commentHandle( { text : comment, startPosition : { row : 0 }, endPosition : { row : 0 } }, filePath )
    })
  }
  else
  {
    let file = _.introspector.File({ data : sourceCode, sys : self.introspector });
    file.refine();

    if( !file.product.byType.gComment )
    return null;

    file.product.byType.gComment.each( ( comment ) => self._commentHandle( comment, filePath ) );
  }
}

//

function _doctrineParseComment( comment, filePath )
{
  let self = this;
  let o =
  {
    strict : false,
    recoverable : true,
    sloppy : true,
    range : true
  }
  try
  {
    return doctrine.parse( doctrine.unwrapComment( comment.text ), o );
  }
  catch( err )
  {
    if( self.vebosity )
    _.errLogOnce( `Failed to parse comment:${comment.text}\nFile:${filePath}\nRow:${comment.startPosition.row}\nReason:`, err )
  }
}

//

function _commentHandle( comment, filePath )
{
  let self = this;

  let structure = self._doctrineParseComment( comment, filePath );

  if( !structure )
  return;
  if( !structure.tags.length )
  return;

  let entity = self._makeSeveralMaybe( structure, comment, filePath );
  self.product.addEntity( entity );
}

//

function _tagsToMap( structure )
{
  let self = this;

  let tags = Object.create( null );

  structure.tags.forEach( ( tag ) =>
  {
    if( tags[ tag.title ] )
    {
      tags[ tag.title ] = _.array.as( tags[ tag.title ] );
      tags[ tag.title ].push( tag );
    }
    else
    tags[ tag.title ] = tag;
  })

  return tags;
}

//

function _typeTagNameGet( tags )
{

  if( tags.routine )
  return 'static routine';

  if( tags.typedef )
  return 'typedef';

  if( tags.constructor )
  return 'constructor';

  if( tags.function )
  return 'function';

  if( tags.method )
  return 'method';

  if( tags.callback )
  return 'callback';

  if( tags.class )
  return 'class';

  if( tags.namespace )
  return 'namespace';

  if( tags.module )
  return 'module';

  return 'entity';
}

//

function _entityMake( o )
{
  let self = this;
  let entity = new _.docgen.EntityJsdoc( o );
  return entity.form();
}

//

function _makeSeveralMaybe( structure, comment, filePath )
{
  let self = this;

  let tags = self._tagsToMap( structure );
  let type = self._typeTagNameGet( tags );
  let position = { start : comment.startPosition, end : comment.endPosition }

  comment = comment.text;

  let result = [];
  let tag = tags[ type ];

  if( !_.arrayIs( tag ) )
  return self._entityMake
  ({
    structure,
    comment,
    filePath,
    position,
    tags,
  });

  for( let i = 0; i < tag.length; i++ )
  {
    let currentTags = _.cloneData({ src : tags });
    currentTags[ type ] = tag[ i ];

    let entity = self._entityMake
    ({
      structure,
      comment,
      filePath,
      position,
      tags : currentTags,
    });
    entity.form();

    result.push( entity );
  }

  return result;
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

let Extension =
{

  _form,

  _parse,

  _doctrineParseComment,
  _commentHandle,

  _tagsToMap,
  _typeTagNameGet,
  _entityMake,
  _makeSeveralMaybe,


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

//

_.docgen[ Self.shortName ] = Self;
if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();

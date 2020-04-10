( function _ParserJsdoc_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' ) {

  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );

  require( '../docparser/IncludeMid.s' );

}

let _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;
  let path = _.fileProvider.path;

  self.suiteTempPath = path.pathDirTempOpen( path.join( __dirname, '../..'  ), 'err' );
  self.assetsOriginalSuitePath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  let path = _.fileProvider.path;
  _.assert( _.strHas( self.suiteTempPath, '/err-' ) )
  path.pathDirTempClose( self.suiteTempPath );
}

// --
// complex
// --

function namespace( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'namespace.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.is( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 3 );
    test.identical( got.orphans.length, 1 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 3 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  .then( ( got ) =>
  {
    let namespace = got.entities[ 0 ];
    var expectedStructure =
    {
      description : `Namespace summary\nNamespace description`,
      tags :
      [
        { title : 'namespace', name : 'TestSpace1' }
      ]
    }
    let expectedPosition =
    {
      start : { row : 0 },
      end : { row : 4 }
    }

    test.is( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  //

  .then( ( got ) =>
  {
    let namespace = got.entities[ 1 ];
    var expectedStructure =
    {
      description : `Namespace summary\nNamespace description`,
      tags :
      [
        { title : 'namespace', name : 'TestSpace2' },
        { title : 'module', name : 'TestModule1' }
      ]
    }
    let expectedPosition =
    {
      start : { row : 6 },
      end : { row : 11 }
    }

    test.is( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  //

  .then( ( got ) =>
  {
    let namespace = got.entities[ 2 ];
    var expectedStructure =
    {
      description : ``,
      tags :
      [
        { title : 'summary', description : 'Namespace summary' },
        { title : 'description', description : 'Namespace description' },
        { title : 'namespace', name : 'TestSpace3' },
        { title : 'module', name : 'TestModule1' }
      ]
    }
    let expectedPosition =
    {
      start : { row : 13 },
      end : { row : 18 }
    }

    test.is( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  //

  return ready;
}

// --
// complex
// --

function complexDocletParse( test )
{
  let a = test.assetFor( 'complexDoclet');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.routinePath
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready.then( ( got ) =>
  {
    test.is( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 1 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    var expectedTags =
    [
      { "title" : `summary`, "description" : `Some summary` },
      {
        "title" : `param`,
        "description" : `Options map`,
        "type" : { "type" : `NameExpression`, "name" : `Object` },
        "name" : `o`
      },
      {
        "title" : `param`,
        "description" : `Some option a`,
        "type" :
        {
          "type" : `OptionalType`,
          "expression" : { "type" : `NameExpression`, "name" : `String` }
        },
        "name" : `o.a`
      },
      {
        "title" : `param`,
        "description" : `Some option b`,
        "type" :
        {
          "type" : `OptionalType`,
          "expression" : { "type" : `NameExpression`, "name" : `Type` }
        },
        "name" : `o.b`,
        "default" : `null`
      },
      {
        "title" : `example`,
        "description" : `//some comment\nvar result = _.someRoutine( a, b )\n//returns something`
      },
      {
        "title" : `throws`,
        "description" : `If somethig is wrong`,
        "type" : { "type" : `NameExpression`, "name" : `Error` }
      },
      {
        "title" : `returns`,
        "description" : `Some data`,
        "type" : { "type" : `NameExpression`, "name" : `Type` }
      },
      {
        "title" : `class`,
        "description" : null,
        "type" : null,
        "name" : `wMatrix`
      },
      { "title" : `method`, "description" : null, "name" : `TestMethod` },
      {
        "title" : `namespace`,
        "description" : null,
        "type" : null,
        "name" : `Tools`
      },
      {
        "title" : `module`,
        "description" : null,
        "type" : null,
        "name" : `Tools/base/someModule`
      },
      { "title" : `customTag`, "description" : `custom-data` }
    ]

    var expectedStructure =
    {
      description : 'Description of a test method',
      tags : expectedTags
    }

    var expectedPosition =
    {
      start : { row : 7 },
      end : { row : 32 },
    }

    let entity = got.entities[ 0 ];

    test.is( _.strDefined( entity.comment ) );
    test.contains( entity.structure, expectedStructure );
    test.identical( entity.filePath, a.abs( 'complex.js' ) );
    test.contains( entity.position, expectedPosition );

    return null;
  })

  //

  return ready;
}

// --
// proto
// --

var Self =
{

  name : 'ParserJsdoc',
  silencing : 1,
  enabled : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalSuitePath : null,
    appJsPath : null
  },

  tests :
  {

    // basic

    namespace,

    //complex

    complexDocletParse
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();

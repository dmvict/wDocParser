( function _ParserJsdoc_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( 'Tools' );
  _.include( 'wTesting' );

  // require( './../docparser/Include.s' );
  require( './../docparser/entry/DocParser.s' );

}

const _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;
  let path = _.fileProvider.path;

  // self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..'  ), 'err' );
  // self.assetsOriginalSuitePath = path.join( __dirname, '_asset' );
  self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..' ), 'err' );
  self.assetsOriginalPath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  let path = _.fileProvider.path;
  _.assert( _.strHas( self.suiteTempPath, '/err-' ) )
  path.tempClose( self.suiteTempPath );
}

// --
// complex
// --

function namespace( test )
{
  let context = this;

  let a = test.assetFor( 'basic' );

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
    test.true( got instanceof _.docgen.Product );
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
      tags : [ { title : 'namespace', name : 'TestSpace1' } ]
    }
    let expectedPosition =
    {
      start : { row : 0 },
      end : { row : 4 }
    }

    test.true( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  /* */

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

    test.true( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  /* */

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

    test.true( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'namespace.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  /* */

  return ready;
}

//

function routine( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'function.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 2 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  .then( ( got ) =>
  {
    let namespace = got.entities[ 0 ];
    var expectedStructure =
    {
      description : `Summary`,
      tags :
      [
        { title : 'function', name : 'entityIdentical' },
        { title : 'function', name : 'identical' },
        { title : 'namespace', name : 'Tools' },
        { title : 'module', name : 'Tools/base/Equaler' }
      ]
    }
    let expectedPosition =
    {
      start : { row : 0 },
      end : { row : 7 }
    }

    test.true( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'function.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  /* */

  .then( ( got ) =>
  {
    let namespace = got.entities[ 1 ];
    var expectedStructure =
    {
      description : `Summary`,
      tags :
      [
        { title : 'function', name : 'entityIdentical' },
        { title : 'function', name : 'identical' },
        { title : 'namespace', name : 'Tools' },
        { title : 'module', name : 'Tools/base/Equaler' }
      ]
    }
    let expectedPosition =
    {
      start : { row : 0 },
      end : { row : 7 }
    }

    test.true( _.strDefined( namespace.comment ) );
    test.contains( namespace.structure, expectedStructure );
    test.identical( namespace.filePath, a.abs( 'function.js' ) );
    test.contains( namespace.position, expectedPosition );

    return got;
  })

  /* */

  return ready;
}

//

function paramGoodRaw( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'param/paramGood.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 2 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  .then( ( got ) =>
  {
    let entity = got.entities[ 0 ];

    let expectedParams =
    [
      {
        'title' : `param`,
        'description' : null,
        'type' : null,
        'name' : `argument`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' : null,
        'name' : `argument`
      },
      {
        'title' : `param`,
        'description' : `Description no dash`,
        'type' : null,
        'name' : `argument`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' :
        {
          'type' : `NameExpression`,
          'name' : `Object`,
        },
        'name' : `options`
      },
      {
        'title' : `param`,
        'description' : `Description without dash`,
        'type' :
        {
          'type' : `NameExpression`,
          'name' : `Object`,
        },
        'name' : `options`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' :
        {
          'type' : `NameExpression`,
          'name' : `Object`,
        },
        'name' : `options.property`
      },
      {
        'title' : `param`,
        'description' : `Description without dash`,
        'type' :
        {
          'type' : `NameExpression`,
          'name' : `Object`,
        },
        'name' : `options.property`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' :
          {
            'type' : `TypeApplication`,
            'expression' :
            {
              'type' : `NameExpression`,
              'name' : `Array`,
            },
            'applications' :
            [
              {
                'type' : `NameExpression`,
                'name' : `String`,
              }
            ],
          }
        },
        'name' : `options.array`
      },
      {
        'title' : `param`,
        'description' : `Description without dash`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' :
          {
            'type' : `TypeApplication`,
            'expression' :
            {
              'type' : `NameExpression`,
              'name' : `Array`,
            },
            'applications' :
            [
              {
                'type' : `NameExpression`,
                'name' : `String`,
              }
            ],
          }
        },
        'name' : `options.array`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' :
          {
            'type' : `NameExpression`,
            'name' : `Boolean`,
          }
        },
        'name' : `options.allowSomething`,
        'default' : `true`
      },
      {
        'title' : `param`,
        'description' : `Description without dash`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' :
          {
            'type' : `NameExpression`,
            'name' : `Boolean`,
          }
        },
        'name' : `options.allowSomething`,
        'default' : `true`
      },
      {
        'title' : `param`,
        'description' : `Description without dash`,
        'type' :
        {
          'type' : `TypeApplication`,
          'expression' :
          {
            'type' : `NameExpression`,
            'name' : `Array`,
          },
          'applications' :
          [
            {
              'type' : `NameExpression`,
              'name' : `Object`,
            }
          ],
        },
        'name' : `objects`
      },
      {
        'title' : `param`,
        'description' : `Description`,
        'type' :
        {
          'type' : `NameExpression`,
          'name' : `String`,
        },
        'name' : `objects[].name`
      }
    ]

    let expectedFunction =
    {
      'title' : `function`,
      'description' : null,
      'name' : `paramTest`
    }

    let expectedNamespace =
    {
      'title' : `namespace`,
      'description' : null,
      'type' : null,
      'name' : `testSpace`
    }

    let expectedTags =
    {
      param : expectedParams,
      function : expectedFunction,
      namespace : expectedNamespace
    }

    test.contains( entity.tags, expectedTags );

    return got;
  })

  /* */

  .then( ( got ) =>
  {
    let entity = got.entities[ 1 ];
    let expectedParams =
    {
      'title' : `param`,
      'description' : null,
      'type' :
      {
        'type' : `RestType`,
        'expression' :
        {
          'type' : `NameExpression`,
          'name' : `Number`,
        },
      },
      'name' : `argument`
    }

    let expectedFunction =
    {
      'title' : `function`,
      'description' : null,
      'name' : `paramTest`
    }

    let expectedNamespace =
    {
      'title' : `namespace`,
      'description' : null,
      'type' : null,
      'name' : `testSpace`
    }

    let expectedTags =
    {
      param : expectedParams,
      function : expectedFunction,
      namespace : expectedNamespace
    }

    test.contains( entity.tags, expectedTags );

    return got;
  })

  /* */

  return ready;
}

//

function paramBadRaw( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'param/paramBad.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 1 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  .then( ( got ) =>
  {
    let entity = got.entities[ 0 ];

    let expectedParams =
    {
      'title' : 'param',
      'description' : null,
      'type' : null,
      'name' : 'argument'
    }

    let expectedFunction =
    {
      'title' : `function`,
      'description' : null,
      'name' : `paramTest`
    }

    let expectedNamespace =
    {
      'title' : `namespace`,
      'description' : null,
      'type' : null,
      'name' : `testSpace`
    }

    let expectedTags =
    {
      param : expectedParams,
      function : expectedFunction,
      namespace : expectedNamespace
    }

    test.contains( entity.tags, expectedTags );

    return got;
  })

  /* */

  return ready;
}

//

function paramGoodTemplateData( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'param/paramGood.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 2 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  .then( ( got ) =>
  {
    let entity = got.entities[ 0 ];

    let expectedParams =
    [
      { 'name' : `argument`, 'description' : null, 'optional' : false },
      { 'name' : `argument`, 'description' : `Description`, 'optional' : false },
      { 'name' : `argument`, 'description' : `Description no dash`, 'optional' : false },
      {
        'name' : `options`,
        'description' : `Description`,
        'optional' : false,
        'type' : `Object`
      },
      {
        'name' : `options`,
        'description' : `Description without dash`,
        'optional' : false,
        'type' : `Object`
      },
      {
        'name' : `options.property`,
        'description' : `Description`,
        'optional' : false,
        'type' : `Object`
      },
      {
        'name' : `options.property`,
        'description' : `Description without dash`,
        'optional' : false,
        'type' : `Object`
      },
      {
        'name' : `options.array`,
        'description' : `Description`,
        'optional' : true,
        'type' : `String[]`
      },
      {
        'name' : `options.array`,
        'description' : `Description without dash`,
        'optional' : true,
        'type' : `String[]`
      },
      {
        'name' : `options.allowSomething`,
        'description' : `Description`,
        'optional' : true,
        'default' : `true`,
        'type' : `Boolean`
      },
      {
        'name' : `options.allowSomething`,
        'description' : `Description without dash`,
        'optional' : true,
        'default' : `true`,
        'type' : `Boolean`
      },
      {
        'name' : `objects`,
        'description' : `Description without dash`,
        'optional' : false,
        'type' : `Object[]`
      },
      {
        'name' : `objects[].name`,
        'description' : `Description`,
        'optional' : false,
        'type' : `String`
      }
    ]

    let expectedTemplateData =
    {
      name : 'paramTest',
      namespace : 'testSpace',
      params : expectedParams
    }

    let templateData = entity.templateDataMake();

    test.contains( templateData, expectedTemplateData );

    return got;
  })

  /* */

  .then( ( got ) =>
  {
    let entity = got.entities[ 1 ];

    let expectedParams =
    [
      {
        'name' : `argument`,
        'description' : null,
        'optional' : false,
        'type' : `...Number`
      }
    ]

    let expectedTemplateData =
    {
      name : 'paramTest',
      namespace : 'testSpace',
      params : expectedParams
    }

    let templateData = entity.templateDataMake();

    test.contains( templateData, expectedTemplateData );

    return got;
  })

  /* */

  return ready;
}

//

function paramBadTemplateData( test )
{
  let a = test.assetFor( 'basic');

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.abs( 'param/paramBad.js' )
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready
  .then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 1 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    return got;
  })

  /* */

  .then( ( got ) =>
  {
    let entity = got.entities[ 0 ];

    let expectedParams =
    [
      {
        'description' : null,
        'name' : 'argument',
        'optional' : false
      }
    ]

    let expectedTemplateData =
    {
      name : 'paramTest',
      namespace : 'testSpace',
      params : expectedParams
    }

    let templateData = entity.templateDataMake();

    test.contains( templateData, expectedTemplateData );

    return got;
  })

  /* */

  return ready;
}

// --
// complex
// --

function complexDocletParse( test )
{
  let a = test.assetFor( 'complexDoclet' );

  a.reflect();

  let jsParser = new _.docgen.ParserJsdoc
  ({
    inPath : a.routinePath
  });

  jsParser.form();
  let ready = jsParser.parse();

  ready.then( ( got ) =>
  {
    test.true( got instanceof _.docgen.Product );
    test.identical( got.entities.length, 1 );
    test.identical( got.orphans.length, 0 );
    test.identical( got.byType.module.length, 0 );
    test.identical( got.byType.namespace.length, 0 )
    test.identical( got.byType.class.length, 0 );

    var expectedTags =
    [
      { 'title' : `summary`, 'description' : `Some summary` },
      {
        'title' : `param`,
        'description' : `Options map`,
        'type' : { 'type' : `NameExpression`, 'name' : `Object` },
        'name' : `o`
      },
      {
        'title' : `param`,
        'description' : `Some option a`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' : { 'type' : `NameExpression`, 'name' : `String` }
        },
        'name' : `o.a`
      },
      {
        'title' : `param`,
        'description' : `Some option b`,
        'type' :
        {
          'type' : `OptionalType`,
          'expression' : { 'type' : `NameExpression`, 'name' : `Type` }
        },
        'name' : `o.b`,
        'default' : `null`
      },
      {
        'title' : `example`,
        'description' : `//some comment\nvar result = _.someRoutine( a, b )\n//returns something`
      },
      {
        'title' : `throws`,
        'description' : `If somethig is wrong`,
        'type' : { 'type' : `NameExpression`, 'name' : `Error` }
      },
      {
        'title' : `returns`,
        'description' : `Some data`,
        'type' : { 'type' : `NameExpression`, 'name' : `Type` }
      },
      {
        'title' : `class`,
        'description' : null,
        'type' : null,
        'name' : `wMatrix`
      },
      { 'title' : `method`, 'description' : null, 'name' : `TestMethod` },
      {
        'title' : `namespace`,
        'description' : null,
        'type' : null,
        'name' : `Tools`
      },
      {
        'title' : `module`,
        'description' : null,
        'type' : null,
        'name' : `Tools/base/someModule`
      },
      { 'title' : `customTag`, 'description' : `custom-data` }
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

    test.true( _.strDefined( entity.comment ) );
    test.contains( entity.structure, expectedStructure );
    test.identical( entity.filePath, a.abs( 'complex.js' ) );
    test.contains( entity.position, expectedPosition );

    return null;
  })

  /* */

  return ready;
}

// --
// proto
// --

const Proto =
{

  name : 'ParserJsdoc',
  silencing : 1,
  enabled : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    // assetsOriginalSuitePath : null,
    assetsOriginalPath : null,
    // appJsPath : null
  },

  tests :
  {

    /* basic */

    namespace,
    routine,

    paramGoodRaw,
    paramBadRaw,

    paramGoodTemplateData,
    paramBadTemplateData,

    /* complex */

    complexDocletParse,

  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();

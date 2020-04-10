( function _IncludeBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wCopyable' );
  _.include( 'wFiles' );
  _.include( 'wConsequence' );

  _.docgen = _.docgen || Object.create( null );
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();

( function _Include_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  require( './include/Base.s' );
  require( './include/Mid.s' );
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();

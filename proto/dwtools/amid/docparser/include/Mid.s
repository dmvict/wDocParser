( function _Include_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  require( './Base.s' );
  
  require( '../l1/Entity.s' );
  require( '../l1/EntityJsdoc.s' );
  require( '../l1/Product.s' );
  
  require( '../l2/aParser.s' );
  require( '../l2/bParserJsdoc.s' );
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();

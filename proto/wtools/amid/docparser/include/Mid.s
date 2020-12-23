( function _Include_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  require( './Base.s' );

  require( '../l1/Namespace.s' );

  require( '../l3/Entity.s' );
  require( '../l3/Product.s' );
  require( '../l3/Parser.s' );

  require( '../l5/EntityJsdoc.s' );
  require( '../l5/ParserJsdoc.s' );
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();

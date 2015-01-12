#include <my/myFoo.h>

//! Comparison operator. \return true if the objects are the same, false otherwise
EXPORT bool operator==( const myFoo &t1, const myFoo &t2 )
{
  return (t1.getFlag() == t2.getFlag());
}

#ifndef myFoo_h
#define myFoo_h

#include <my/myConfig.h>

/*!
  \class myFoo

  Class provided as a template example.
*/
class EXPORT myFoo
{
public:
  //! Default constructor.
  myFoo() : m_flag(false) {};
  //! Copy constructor.
  myFoo(const myFoo &t) : m_flag(false) {
    *this = t;
  }
  //! Destructor.
  virtual ~myFoo() {};
  //! Copy operator.
  inline const myFoo& operator=(const myFoo &t) {
    this->m_flag = t.m_flag;
    return *this;
  }
  //! \return Value of the flag.
  inline bool getFlag() const {
    return m_flag;
  }
  //! Set flag value.
  inline void setFlag(const bool &flag) {
    m_flag = flag;
  }

  friend EXPORT bool operator==( const myFoo &t1, const myFoo &t2 );

protected:
  bool m_flag; //!< Parameter used for...
};

#endif

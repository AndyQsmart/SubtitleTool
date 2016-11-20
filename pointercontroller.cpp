#include "pointercontroller.h"

template<class T>
PointerController<T>::PointerController()
{

}

template<class T>
void PointerController<T>::addPointer(int id, T *p)
{
    T *t;
    if (pool.find(id) != pool.end())
    {
        t = pool[id];
        pool.remove(id);
        delete t;
    }
    pool[id] = p;
}

template<class T>
void PointerController<T>::deletePointer(int id)
{
    T *p = pool[id];
    pool.remove(id);
    delete p;
}

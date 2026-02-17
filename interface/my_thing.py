from ctypes import *
import numpy as np
from os.path import dirname,abspath,join,exists
from inspect import getsourcefile

# C struc definition
class this_t(Structure):
    _fields_=[
        ("i", c_int),
        ("i1", POINTER(c_int))
    ]

class this():

    def __init__(self):
        self.lib = None
        ## do the proper loading of lib.so

        # declare internal this_t
        self._this = this_t()

        self._i1_shape=0

        # initialize it
        self.lib.this_create.restype=None
        self.lib.this_create.argtypes=[ POINTER(this_t) ]
        self.lib.this_create( byref(self._this) )

    def __del__(self):
        return

    def compute(self):
        """!
        launch compute function (the docstrings need the '!' symbol i think)
        """
        ### do this properly
        # self.lib.this_compute.restype=None
        # self.lib.this_compute.argtypes=[ POINTER(this_t) ]
        return

    # define getter for i as @property
    @property
    def i(self):
        """!
        single integer
        """
        return self._this.i

    # define a setter for i
    @i.setter
    def i(self, val):
        self._this.i = c_int(val)

    # getter for i1
    @property
    def i1(self):
        """!
        rank-1 integer
        """
        if( self._i1_shape == 0 ):
            return
        return np.ctypeslib.as_array( self._this.i1, self._i1_shape )

    # # setter for i1 (i1 is expected intent(out), so no setter. But this is the principle)
    # @i1.setter
    # def i1( self, val ):
    #     self._i1_shape=np.shape(val)
    #     arr = np.ascontiguousarray( val, dtype=np.int32 ) # make contiguous
    #     self._i1_buf = arr # keep a ref to `arr` otherwise the garbge collector destroys it
    #     self._this.i1 = arr.ctypes.data_as( POINTER(c_int) )

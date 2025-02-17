# -*- coding: utf-8 -*-
from libcpp.vector cimport vector
from libcpp cimport bool

cimport pcl_defs as cpp
cimport pcl_filters_180 as pcl_fil

cimport eigen as eigen3

from boost_shared_ptr cimport shared_ptr

cdef class ConditionalRemoval:
    """
    Must be constructed from the reference point cloud, which is copied, so
    changed to pc are not reflected in ConditionalRemoval(pc).
    """
    cdef pcl_fil.ConditionalRemoval_t *me

    def __cinit__(self, ConditionAnd cond):
        # self.me = new pcl_fil.ConditionalRemoval_t(<pcl_fil.ConditionBase_t*>cond.me)
        # direct - NG
        self.me = new pcl_fil.ConditionalRemoval_t()
        self.me.setCondition(<pcl_fil.ConditionBasePtr_t>cond.me)

    # def __dealloc__(self):
    #    # MemoryAccessError
    #    # del self.me
    #    self.me

    def set_KeepOrganized(self, flag):
        self.me.setKeepOrganized(flag)

    def filter(self):
        """
        Apply the filter according to the previously set parameters and return
        a new pointcloud
        """
        cdef PointCloud pc = PointCloud()
        self.me.filter(pc.thisptr()[0])
        return pc

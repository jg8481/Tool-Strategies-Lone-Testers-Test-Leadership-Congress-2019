class TimeTrackingListener(object):
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self

    def _end_test(self, name, attrs):
        print ('%s => status: %s, elapsed time: %s ms' % (name, attrs['status'], attrs['elapsedtime']))

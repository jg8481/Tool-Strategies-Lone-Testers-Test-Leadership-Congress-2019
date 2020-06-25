class DurationTrackingListener(object):
    ROBOT_LISTENER_API_VERSION = 3

# The following will measure the duration of each test. This listener will fail each test if they run beyond the maximum run time (max_seconds).

    def __init__(self, max_seconds=10):
        self.max_milliseconds = float(max_seconds) * 1000

    def end_test(self, data, test):
        if test.status == 'PASS' and test.elapsedtime > self.max_milliseconds:
            test.status = 'FAIL'
            test.message = 'FAIL --> FATAL ERROR -- Individual test execution took too long.'

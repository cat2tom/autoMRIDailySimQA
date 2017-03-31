from datetime import datetime
from threading import Timer

class PeriodicTask(object):
    def __init__(self, interval, callback, daemon=True, **kwargs):
        self.interval = interval
        self.callback = callback
        self.daemon   = daemon
        self.kwargs   = kwargs

    def run(self):
        self.callback(**self.kwargs)
        t = Timer(self.interval, self.run)
        t.daemon = self.daemon
        t.start()

def foo():
    print datetime.now()
    
    print 'test'

task = PeriodicTask(interval=1, callback=foo)
task.run()
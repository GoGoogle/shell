##修复`pip ModuleNotFoundError: No module named 'lsb_release'` `（lsb_release -a）`报错的问题##

现象：

```
$ pip3 search cctv
ERROR: Exception:
Traceback (most recent call last):
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/cli/base_command.py", line 178, in main
    status = self.run(options, args)
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/commands/search.py", line 48, in run
    pypi_hits = self.search(query, options)
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/commands/search.py", line 62, in search
    with self._build_session(options) as session:
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/cli/base_command.py", line 92, in _build_session
    insecure_hosts=options.trusted_hosts,
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/download.py", line 380, in __init__
    self.headers["User-Agent"] = user_agent()
  File "/usr/Py373/lib/python3.7/site-packages/pip/_internal/download.py", line 134, in user_agent
    zip(["name", "version", "id"], distro.linux_distribution()),
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 122, in linux_distribution
    return _distro.linux_distribution(full_distribution_name)
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 677, in linux_distribution
    self.version(),
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 737, in version
    self.lsb_release_attr('release'),
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 899, in lsb_release_attr
    return self._lsb_release_info.get(attribute, '')
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 552, in __get__
    ret = obj.__dict__[self._fname] = self._f(obj)
  File "/usr/Py373/lib/python3.7/site-packages/pip/_vendor/distro.py", line 1012, in _lsb_release_info
    stdout = subprocess.check_output(cmd, stderr=devnull)
  File "/usr/Py373/lib/python3.7/subprocess.py", line 395, in check_output
    **kwargs).stdout
  File "/usr/Py373/lib/python3.7/subprocess.py", line 487, in run
    output=stdout, stderr=stderr)
subprocess.CalledProcessError: Command '('lsb_release', '-a')' returned non-zero exit status 1.
```

重点：

`subprocess.CalledProcessError: Command '('lsb_release', '-a')' returned non-zero exit status 1.`

也就是执行`lsb_release -a`会出错。

参考：https://askubuntu.com/questions/965043/no-module-named-lsb-release-after-install-python-3-6-3-from-source

```
$ python3
Python 3.7.3 (default, May 21 2019, 15:12:11)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import lsb_release
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'lsb_release'
```

Ctrl+D退出

```
$ python3.5
Python 3.5.3 (default, Sep 27 2018, 17:25:39)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import lsb_release
>>> lsb_release.__file__
'/usr/lib/python3/dist-packages/lsb_release.py'
```

Ctrl+D退出

检查一下这个文件：

```
ll /usr/lib/python3/dist-packages/lsb_release.py
lrwxrwxrwx 1 root root 38 11月 25  2016 /usr/lib/python3/dist-packages/lsb_release.py -> ../../../share/pyshared/lsb_release.py
```

嗯，软链，确定了是类似问题，然后查找所有的`lsb_release.py`

```
$ find /usr -name lsb_release.py
/usr/lib/python3/dist-packages/lsb_release.py
/usr/lib/python2.7/dist-packages/lsb_release.py
```

发现这俩全都指向了：

/usr/share/pyshared/lsb_release.py

那么，就去查看`/usr/Py373/lib/python3.7/site-packages/`下有没有`lsb_release.py`

结果是没有的；

接下来，就创建一个软链接：

`ln -s /usr/share/pyshared/lsb_release.py /usr/Py373/lib/python3.7/site-packages/lsb_release.py`

然后再检查：

```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 9.9 (stretch)
Release:        9.9
Codename:       stretch
```
发现`lsb_release -a`正常了

再检查`pip3 search cctv`，也不报错了，这算是修好了？

```
$ pip3 search cctv
picctv (0.1.2)  - CCTV for the RaspberryPi & Camera Module.
```

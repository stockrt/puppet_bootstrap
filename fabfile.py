# coding: utf-8
from fabric.api import *

env.user = 'root'
#env.roledefs = {
#    'web': ['<your_host>'],
#}

bootstrap_tempdir = '/tmp/bootstrap'
fabputdir_tempfile = '/tmp/fabputdir.tar.gz'

## upload dir
def _put_dir(local_dir, remote_dir, force=False):
    local('tar -C %s -czf %s .' % (local_dir, fabputdir_tempfile))
    put(fabputdir_tempfile, fabputdir_tempfile)
    if force:
        run('rm -rf %s' % remote_dir)
    run('mkdir -p %s >/dev/null 2>&1' % remote_dir)
    run('tar -C %s -xzof %s' % (remote_dir, fabputdir_tempfile))
## end upload dir

## bootstrap
#@roles('web')
def bootstrap():
    _put_dir('bootstrap', bootstrap_tempdir)
    run('chmod 755 %s/bootstrap.sh' % bootstrap_tempdir)
    run('%s/bootstrap.sh' % bootstrap_tempdir)
## end bootstrap

## puppet
#@roles('web')
def puppet_deploy(force=''):
    if force == 'force':
        _put_dir('puppet', '/etc/puppet', force=True)
    else:
        _put_dir('puppet', '/etc/puppet')

#@roles('web')
def puppet_sync():
    run('puppet -v --modulepath=/etc/puppet/modules /etc/puppet/manifests/site.pp')

#@roles('web')
def puppet(force=''):
    puppet_deploy(force)
    puppet_sync()
## end puppet

def help():
    print
    print '# bootstrap'
    print '  fab bootstrap -H <your_host> -p <root_password>'
    print '  fab bootstrap'
    print
    print '# puppet deploy'
    print '  fab puppet_deploy -H <your_host> -p <root_password>'
    print '  fab puppet_deploy'
    print '  fab puppet_deploy:force -H <your_host> -p <root_password>'
    print '  fab puppet_deploy:force'
    print
    print '# puppet sync'
    print '  fab puppet_sync -H <your_host> -p <root_password>'
    print '  fab puppet_sync'
    print
    print '# puppet deploy and sync at once'
    print '  fab puppet -H <your_host> -p <root_password>'
    print '  fab puppet'
    print '  fab puppet:force -H <your_host> -p <root_password>'
    print '  fab puppet:force'
    print
    print 'You may not specify "-H <your_host>" to run puppet against the default machines. Just fix/uncomment:'
    print '  fabfile.py                 -> fix/uncomment "\'web\': [\'<your_host>\']" and uncomment "@roles(\'web\')"'
    print '  puppet/manifests/nodes.pp  -> fix "node <your_host> inherits basenode"'
    print
    print 'You may also not specify "-p <root_password>" if you have your ssh pub key configured into root\'s authorized_keys.'
    print 'This sample already does this, with **my** pub key, so, watch out :)'

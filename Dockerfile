FROM centos:7

ENV RELEASE mimic
ENV DISTRO el7

ADD ceph.repo /etc/yum.repos.d/ceph.repo
ADD kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN sed -i "s/{distro}/$DISTRO/g; s/{ceph-release}/$RELEASE/g" /etc/yum.repos.d/ceph.repo
RUN rpm --import 'https://download.ceph.com/keys/release.asc' && \
  yum install -y epel-release && \
  yum install -y unzip ceph-osd ceph-mon ceph-mds ceph-mgr ceph-base ceph-common ceph-radosgw rbd-mirror device-mapper jq kubectl e2fsprogs wget && \
  yum clean all && \
  rm -rf /var/cache/yum

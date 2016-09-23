class rabbitmq::queue inherits rabbitmq {
  
  rabbitmq_queue { "$queue_name":
    user        => $queue_user,
    password    => $queue_passwd,
    durable     => $queue_durable,
    auto_delete => $queue_autodel,
    ensure      => present,
  }
}

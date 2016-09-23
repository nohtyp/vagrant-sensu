class rabbitmq::exchanges inherits rabbitmq {
  
  rabbitmq_exchange { "$exchange_name":
    user        => $exchange_user,
    password    => $exchange_passwd,
    type        => $exchange_type,
    durable     => $exchange_durable,
    auto_delete => $exchange_autodel,
    internal    => $exchange_internal,
    ensure      => present,
  }
}

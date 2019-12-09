require "spec2"
include Spec2::GlobalDSL

require "../src/sonic"

require "./support/client_context"
require "./support/channel_examples"

Spec2.configure_reporter(Spec2::Reporters::Doc)
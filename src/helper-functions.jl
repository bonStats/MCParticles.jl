function normalise(logw::Vector)
    nrml = logsumexp(logw)
    return logw - repeat([nrml], length(logw))
end

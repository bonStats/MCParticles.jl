function safe_normalise(logw::Vector)
    b = maximum(logw)
    nlogw = logw - repeat([b], length(logw))
    return nlogw - repeat([log(sum(exp.(nlogw)))], length(logw))
end

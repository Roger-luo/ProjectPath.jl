module ProjectPath

using Pkg

function project(m::Module, xs...)
    path = pathof(m)
    path === nothing && return dirname(Pkg.project().path)
    return normpath(joinpath(dirname(dirname(path)), xs...))
end

src(m::Module, xs...) = project(m, "src", xs...)
deps(m::Module, xs...) = project(m, "deps", xs...)
test(m::Module, xs...) = project(m, "test", xs...)

macro include(xs...)
    return esc(:(Base.include($project($__module__, "src", $(xs...)))))
end

macro project(xs...)
    return esc(:($project($__module__, $(xs...))))
end

end

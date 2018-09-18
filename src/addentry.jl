function Maketile()

    print("Type:")
    bt = readline()
    bt = lowercase(bt)

    print("Producer:")
    prod = readline()
    prod = lowercase(prod)

    print("Material:")
    gt = readline()

    print("Run Reference:")
    rr = readline()

    println("General Comments")
    gen_com = []

    println("Properties")
    print("Geometry:")
    geo = readline()
    geo = lowercase(geo)
    print("Size:")
    sz = readline()

    print("Tile Number:")
    tn = readline()

    print("Properties Comments:")
    prop_com = []

    lbl = "$bt-$gt-$prod-$rr-$tn"
    uuid = ""
    print("UUID:")
    uuid = replace(readline(),'/','-')

    dict = Dict("Batch Type"=>bt, "label"=>lbl,"Run Reference"=>rr,"General Comments"=>gen_com,"UUID"=>uuid, "Tile Number"=>tn,

            "Properties"=>Dict("Geometry"=>geo,"Size"=>sz,"material"=>gt,
                "date"=>"","process"=>"","Properties Comments"=>prop_com),

            "Measurements"=>Dict("wavelength"=> Dict()
            , "peak wavelength"=> Dict()
            , "light output"=> Dict()
            , "absorbed at 430nm"=>Dict()))

    target_dir = "catalogue/$bt/$gt/$prod/$rr/Tiles/$tn"

    if !isdir(target_dir)
        mkpath(target_dir)
    end

    export_dict = Dict(lbl=>dict)

    filename = target_dir*"/"*uuid[1:8]*lbl*".json"

    stringdata = JSON.json(export_dict)
    open(filename, "w") do f
        write(f, stringdata)
    end
end

export Maketile

function Makebatch()

    lbl = ""
    uuid = ""
    typ = "Batch"
    dict = Dict()

    print("Batch Type:")
    bt = readline()
    bt = lowercase(bt)

    if bt == "granulate"
        bt = "Granulate"
        print("Granulate Type:")
        gt = readline()
        print("Manufacturer:")
        man=readline()
        manlbl = lowercase(man[1:3])
        print("Batch Number:")
        bn = readline()
        lbl = "gran-$manlbl-$gt-$bn"
        print("UUID:")
        uuid = replace(readline(),'/','-')
        dict = Dict("Type"=>typ,"Product"=>bt,"label"=>lbl,"UUID"=>uuid,"Product"=>gt,"Manufacturer"=>man,"Batch Number"=>bn)
        target_dir = "catalogue/$typ/$bt/$gt/$bn/"

    elseif bt == "raw pen"
        bt = "rawpen"
        print("Mass:")
        m = readline()
        print("Creation Date:")
        date = readline()
        print("Manufacturer:")
        man = readline()
        print("Batch Number")
        bn = readline()
        lbl = lowercase(bt)*"-$man-$bn"
        print("UUID:")
        uuid = replace(readline(),'/','-')
        dict = Dict("Type"=>typ,"Product"=>bt,"label"=>lbl, "UUID"=>uuid,"mass"=>m,
                "Creation"=>Dict("date"=>date,"manufacturer"=>man))
        target_dir = "catalogue/$typ/$bt/$gt/$bn/"

    elseif bt == "tile"
        bt = "Tile"
        print("Manufacturer")
        man = readline()
        print("Run Reference:")
        rr = readline()
        bn = rr
        print("Creation Date:")
        date = readline()
        print("Process:")
        pr = readline()
        print("Material:")
        gt = readline()
        print("UUID:")
        uuid = replace(readline(),'/','-')
        lbl = "$bt-$gt-$man-$rr"

        print("Predrying Temp:")
        pdt = readline()
        print("Predrying Time:")
        pdtime = readline()
        print("Humidity:")
        hum = readline()
        print("Clamping Force")
        force = readline()

        println("Heating Profile")
        print("Inlet:")
        itemp = readline()
        print("Zone4:")
        z4 = readline()
        print("Zone3:")
        z3 = readline()
        print("Zone2:")
        z2 = readline()
        print("Zone1:")
        z1 = readline()
        print("Nozzle")
        nz = readline()

        print("Mold Temperature: ")
        mt_set = readline()
        print("Mold Temp (ejector):")
        mt_ej = readline()
        print("Mold Temp (nozzle):")
        mt_nz = readline()
        temp_dict = Dict("Mold Temp"=>mt_set, "Mold Temp (ejector)"=>mt_ej, "Mold Temp (nozzle)"=>mt_nz)

        print("Torque Dosing:")
        td = readline()
        print("Dosing Volume:")
        dv = readline()
        print("Circumferential Speed:")
        cs = readline()
        print("Back Pressure:")
        bp = readline()
        print("Cooling Time:")
        ct = readline()

        print("Water Cooling")
        wc = readline()
        print("Injection Pressure:")
        ip = readline()
        print("Injection Speed:")
        is = readline()
        print("Injection Time:")
        it = readline()
        inj_dict = Dict("Injection Speed"=>is,"Injection Time"=>it,"Injection Pressure"=>ip)

        print("Switchover Point:")
        sp = readline()
        print("Holding Pressure:")
        hp = readline()
        print("Holding Pressure Time:")
        hpt = readline()
        print("Holding Pressure Speed:")
        hps = readline()
        print("Melt Cushion: ")
        mc = readline()

        print("Comments:")
        com = []

        dict = Dict("Type"=>typ, "Product"=>bt, "label"=>lbl,"Run Reference"=>rr,"UUID"=>uuid,
            "Creation"=>Dict("date"=>date,"manufacturer"=>man,"process"=>pr,"material"=>gt,
                "Drying Temp"=>pdt,"Drying Time"=>pdtime, "Humidity"=>hum, "Clamping Force"=>force,
                "Temp Profile"=>Dict("Inlet [C]"=>itemp,"Zone4 []"=>z4,"Zone3"=>z3,"Zone2"=>z2,"Zone1"=>z1,"Nozzle"=>nz),
                "Mold Temps"=>Dict("Mold Temp [C]"=>mt_set, "Mold Temp (ejector) [C]"=>mt_ej, "Mold Temp (nozzle) [C]"=>mt_nz),
                "Injection Paramaters"=>Dict("Injection Speed [cm^3/s]"=>is,"Injection Time [s]"=>it,"Injection Pressure [bar]"=>ip),
                "Torque Dosing [Nm]"=> td, "Dosing Volume [cm^3]"=>dv,"Circumferential Speed [m/min]"=>cs,"Back Pressure [bar]"=>bp,"Cooling Time [s]"=>ct,
                "Switchover Point [cm^3]"=>sp,"Holding Pressure [bar]"=>hp,"Holding Pressure Time [s]"=>hpt,"Holding Pressure Speed [cm^3/s]"=>hps,
                "Melt Cushion [cm^3]"=>mc,"Comments"=>com))
        target_dir = "catalogue/$typ/$bt/$gt/$man/$bn/"
    end

    if isdir(target_dir)
        println("Batch Already Exists")
        return
    else
        mkpath(target_dir)
    end

    export_dict = Dict(lbl=>dict)

    filename = target_dir*uuid[1:8]*lbl*".json"

    stringdata = JSON.json(export_dict)
    open(filename, "w") do f
        write(f, stringdata)
    end


end

export Makebatch

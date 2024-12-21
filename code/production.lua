function 
    local taskname = "userTask"
    log.info(taskname, "start")

    sys.wait(30000)
    local netid = 1
    local netmsg = "UART_DATA_TO_NET" .. netid
    local uid = 2
    local uartmsg = "UART" .. uid .. "_NEED_SEND"
    local rd = nil
    local cmd = {
        {0x01, 0x03, 0x00, 0x00, 0x00, 0x05, 0x85, 0xC9},
        {0x68, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0x68, 0x13, 0x00, 0xDF, 0x16}, 
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x36, 0x35, 0x24, 0x16}, -- pow
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x35, 0x35, 0x23, 0x16}, -- curr A
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x34, 0x35, 0x22, 0x16}, -- volt A
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x33, 0x33, 0x22, 0x16}, -- tpow
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x34, 0x34, 0x33, 0x37, 0x22, 0x16}, -- date
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x35, 0x34, 0x33, 0x37, 0x22, 0x16}, -- time
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x34, 0x33, 0x22, 0x16}, -- t+pow
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x35, 0x33, 0x22, 0x16}, -- t-pow
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x34, 0x34, 0x22, 0x16}, -- t+pow + time
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x35, 0x34, 0x22, 0x16}, -- t-pow + time
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x34, 0x35, 0x22, 0x16}, -- volt B
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x34, 0x35, 0x22, 0x16}, -- volt C
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x35, 0x35, 0x22, 0x16}, -- curr B
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x35, 0x35, 0x22, 0x16}, -- curr C
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x36, 0x35, 0x24, 0x16}, -- pow A
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x36, 0x35, 0x24, 0x16}, -- pow B
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x36, 0x35, 0x24, 0x16}, -- pow C
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x38, 0x35, 0x24, 0x16}, -- 总视在功率
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x38, 0x35, 0x24, 0x16}, -- A视在功率
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x38, 0x35, 0x24, 0x16}, -- B视在功率
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x38, 0x35, 0x24, 0x16}, -- C视在功率
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x34, 0x33, 0x24, 0x16}, -- 当前正向有功电能数据块(总、尖、峰、平、谷)
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x34, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x34, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x34, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x37, 0x34, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x33, 0x35, 0x33, 0x24, 0x16}, -- 当前反向有功电能数据块(总、尖、峰、平、谷)
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x34, 0x35, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x35, 0x35, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x36, 0x35, 0x33, 0x24, 0x16},
        {0x68, 0x61, 0x57, 0x85, 0x09, 0x03, 0x24, 0x68, 0x11, 0x04, 0x33, 0x37, 0x35, 0x33, 0x24, 0x16}
    }
    local ncmd = nil
    local crcr = nil
    prouart.ProuartStopProReciveCache(1)
    pronet.PronetStopProNetRecive(1)

    local iccid = sim.getIccid()        
    local imei = misc.getImei()

    local meterAddress = nil

    while true do
        local temp1 = 0
        local hum1 = 0
        local curr = 0
        local volt = 0
        local pow = 0
        local tpow = 0

        while true do 
            rd = prouart.ProuartGetReciveChaceAndDel(uid)
            if rd == nil then 
                break
            end 
        end

        for i = 1, #cmd, 1 do 
            local retry_count = 0
            local max_retries = 5
            rd = nil

            while retry_count < max_retries and rd == nil do
                ncmd = usertool.ToolTableToHexStr(cmd[i])
                prouart.ProuartSetSendChace(uid, ncmd)
                sys.publish(uartmsg)
                sys.wait(1000)
                rd = prouart.ProuartGetReciveChaceAndDel(uid)
                if rd == nil then
                    retry_count = retry_count + 1
                    sys.wait(1000)
                end
            end 
            if rd == nil then 
                log.info(taskname, "Failed to receive data after", max_retries, "retries")
            end 
            if rd then 
                log.info(taskname, "cmd num=", i, "rd data=", string.toHex(rd))
                rd = usertool.ToolHexStrToTable(rd)
                local fecount = 0
                if rd then 
                    crcr = usertool.ToolCheckModbusCRC16(rd, #rd, 0)
                    if rd[1] == 254 then fecount = fecount + 1 end
                    if rd[2] == 254 then fecount = fecount + 1 end
                    if rd[3] == 254 then fecount = fecount + 1 end
                    if rd[4] == 254 then fecount = fecount + 1 end
                    log.info(taskname, "FE count=", fecount)
                    if crcr == 1 then 
                        if i == 1 then
                            temp1 = (rd[4] * 256 + rd[5]) * 0.1
                            hum1 = (rd[6] * 256 + rd[7]) * 0.1
                        end     
                    end             
                    if i == 2 then 
                        local hex_str_1 = string.format("%02X", rd[fecount +11 ] - 0x33) 
                        local hex_str_2 = string.format("%02X", rd[fecount + 12 ] - 0x33) 
                        local hex_str_3 = string.format("%02X", rd[fecount + 13 ] - 0x33)
                        local hex_str_4 = string.format("%02X", rd[fecount + 14 ] - 0x33)
                        local hex_str_5 = string.format("%02X", rd[fecount + 15 ] - 0x33)
                        local hex_str_6 = string.format("%02X", rd[fecount + 16 ] - 0x33)

                        local concatenated_str = hex_str_6 .. hex_str_5 .. hex_str_4 .. hex_str_3 .. hex_str_2 .. hex_str_1 
                        log.info(taskname, "concate str:", concatenated_str )
                        meterAddress  = concatenated_str
                        local address_bytes = {
                            tonumber(hex_str_1, 16),
                            tonumber(hex_str_2, 16),
                            tonumber(hex_str_3, 16),
                            tonumber(hex_str_4, 16),
                            tonumber(hex_str_5, 16),
                            tonumber(hex_str_6, 16)
                        }

                        for j = 1, 6 do
                            for k = 3, 14 do 
                                cmd[k][j+1] = address_bytes[j]
                            end
                        end

                        local checksum1 = 0
                        local checksum2 = 0
                        local checksum3 = 0
                        local checksum4 = 0
                        local checksum5 = 0
                        local checksum6 = 0
                        local checksum7 = 0
                        local checksum8 = 0
                        local checksum9 = 0
                        local checksum10 = 0
                        local checksum11 = 0
                        local checksum12 = 0
                        local checksum13 = 0
                        local checksum14 = 0
                        local checksum15 = 0
                        local checksum16 = 0
                        local checksum17 = 0
                        local checksum18 = 0
                        local checksum19 = 0
                        local checksum20 = 0
                        local checksum21 = 0

                        local checksum22 = 0
                        local checksum23 = 0
                        local checksum24 = 0
                        local checksum25 = 0
                        local checksum26 = 0

                        local checksum27 = 0
                        local checksum28 = 0
                        local checksum29 = 0
                        local checksum30 = 0
                        local checksum31 = 0
                        
                        for j = 1, 14 do
                            checksum1 = checksum1 + cmd[3][j]
                            checksum2 = checksum2 + cmd[4][j]
                            checksum3 = checksum3 + cmd[5][j]
                            checksum4 = checksum4 + cmd[6][j]
                            checksum5 = checksum5 + cmd[7][j]
                            checksum6 = checksum6 + cmd[8][j]
                            checksum7 = checksum7 + cmd[9][j]
                            checksum8 = checksum8 + cmd[10][j]
                            checksum9 = checksum9 + cmd[11][j]
                            checksum10 = checksum10 + cmd[12][j]
                            checksum11 = checksum11 + cmd[13][j]
                            checksum12 = checksum12 + cmd[14][j]
                            checksum13 = checksum13 + cmd[15][j]
                            checksum14 = checksum14 + cmd[16][j]
                            checksum15 = checksum15 + cmd[17][j]
                            checksum16 = checksum16 + cmd[18][j]
                            checksum17 = checksum17 + cmd[19][j]
                            checksum18 = checksum18 + cmd[20][j]
                            checksum19 = checksum19 + cmd[21][j]
                            checksum20 = checksum20 + cmd[22][j]
                            checksum21 = checksum21 + cmd[23][j]

                            checksum22 = checksum22 + cmd[24][j]
                            checksum23 = checksum23 + cmd[25][j]
                            checksum24 = checksum24 + cmd[26][j]
                            checksum25 = checksum25 + cmd[27][j]
                            checksum26 = checksum26 + cmd[28][j]

                            checksum27 = checksum27 + cmd[29][j]
                            checksum28 = checksum28 + cmd[30][j]
                            checksum29 = checksum29 + cmd[31][j]
                            checksum30 = checksum30 + cmd[32][j]
                            checksum31 = checksum31 + cmd[33][j]
                        end
                        cmd[3][15] = bit.band(checksum1, 0xFF)
                        cmd[4][15] = bit.band(checksum2, 0xFF)
                        cmd[5][15] = bit.band(checksum3, 0xFF)
                        cmd[6][15] = bit.band(checksum4, 0xFF)
                        cmd[7][15] = bit.band(checksum5, 0xFF)
                        cmd[8][15] = bit.band(checksum6, 0xFF)
                        cmd[9][15] = bit.band(checksum7, 0xFF)
                        cmd[10][15] = bit.band(checksum8, 0xFF)
                        cmd[11][15] = bit.band(checksum9, 0xFF)
                        cmd[12][15] = bit.band(checksum10, 0xFF)
                        cmd[13][15] = bit.band(checksum11, 0xFF)
                        cmd[14][15] = bit.band(checksum12, 0xFF)
                        cmd[15][15] = bit.band(checksum13, 0xFF)
                        cmd[16][15] = bit.band(checksum14, 0xFF)
                        cmd[17][15] = bit.band(checksum15, 0xFF)
                        cmd[18][15] = bit.band(checksum16, 0xFF)
                        cmd[19][15] = bit.band(checksum17, 0xFF)
                        cmd[20][15] = bit.band(checksum18, 0xFF)
                        cmd[21][15] = bit.band(checksum19, 0xFF)
                        cmd[22][15] = bit.band(checksum20, 0xFF)
                        cmd[23][15] = bit.band(checksum21, 0xFF)

                        cmd[24][15] = bit.band(checksum22, 0xFF)
                        cmd[25][15] = bit.band(checksum23, 0xFF)
                        cmd[26][15] = bit.band(checksum24, 0xFF)
                        cmd[27][15] = bit.band(checksum25, 0xFF)
                        cmd[28][15] = bit.band(checksum26, 0xFF)

                        cmd[29][15] = bit.band(checksum27, 0xFF)
                        cmd[30][15] = bit.band(checksum28, 0xFF)
                        cmd[31][15] = bit.band(checksum29, 0xFF)
                        cmd[32][15] = bit.band(checksum30, 0xFF)
                        cmd[33][15] = bit.band(checksum31, 0xFF)

                        local function printHexArray(array)
                            local hexArray = {}
                            for k, v in ipairs(array) do
                                table.insert(hexArray, string.format("%02X", v))
                            end
                            return table.concat(hexArray, " ")
                        end

                        log.info(taskname, "Updated cmd[3]: ", printHexArray(cmd[3]))
                        log.info(taskname, "Updated cmd[4]: ", printHexArray(cmd[4]))
                        log.info(taskname, "Updated cmd[5]: ", printHexArray(cmd[5]))
                        log.info(taskname, "Updated cmd[6]: ", printHexArray(cmd[6]))
                        log.info(taskname, "Updated cmd[7]: ", printHexArray(cmd[7]))
                        log.info(taskname, "Updated cmd[8]: ", printHexArray(cmd[8]))
                        log.info(taskname, "Updated cmd[9]: ", printHexArray(cmd[9]))
                        log.info(taskname, "Updated cmd[10]: ", printHexArray(cmd[10]))
                        log.info(taskname, "Updated cmd[11]: ", printHexArray(cmd[11]))
                        log.info(taskname, "Updated cmd[12]: ", printHexArray(cmd[12]))
                        log.info(taskname, "Updated cmd[13]: ", printHexArray(cmd[13]))
                        log.info(taskname, "Updated cmd[14]: ", printHexArray(cmd[14]))
                        log.info(taskname, "Updated cmd[15]: ", printHexArray(cmd[15]))
                        log.info(taskname, "Updated cmd[16]: ", printHexArray(cmd[16]))
                        log.info(taskname, "Updated cmd[17]: ", printHexArray(cmd[17]))
                        log.info(taskname, "Updated cmd[18]: ", printHexArray(cmd[18]))
                        log.info(taskname, "Updated cmd[19]: ", printHexArray(cmd[19]))
                        log.info(taskname, "Updated cmd[20]: ", printHexArray(cmd[20]))
                        log.info(taskname, "Updated cmd[21]: ", printHexArray(cmd[21]))
                        log.info(taskname, "Updated cmd[22]: ", printHexArray(cmd[22]))
                        log.info(taskname, "Updated cmd[23]: ", printHexArray(cmd[23]))

                        log.info(taskname, "Updated cmd[24]: ", printHexArray(cmd[24]))
                        log.info(taskname, "Updated cmd[25]: ", printHexArray(cmd[25]))
                        log.info(taskname, "Updated cmd[26]: ", printHexArray(cmd[26]))
                        log.info(taskname, "Updated cmd[27]: ", printHexArray(cmd[27]))
                        log.info(taskname, "Updated cmd[28]: ", printHexArray(cmd[28]))

                        log.info(taskname, "Updated cmd[29]: ", printHexArray(cmd[29]))
                        log.info(taskname, "Updated cmd[30]: ", printHexArray(cmd[30]))
                        log.info(taskname, "Updated cmd[31]: ", printHexArray(cmd[31]))
                        log.info(taskname, "Updated cmd[32]: ", printHexArray(cmd[32]))
                        log.info(taskname, "Updated cmd[33]: ", printHexArray(cmd[33]))
                    end
                    if i == 6 then
                        local hex_str_19 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                        local hex_str_20 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                        local hex_str_21 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                        local hex_str_22 = string.format("%02X", rd[fecount + 10 + 8] - 0x33)  
                        local concatenated_str =  hex_str_22 .. hex_str_21 .. hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        log.info(taskname, "tpow decimal_value :", decimal_value )
                        tpow = (decimal_value) * 0.01
                    end
                    if i == 7 then 
                        log.info(taskname, "WW: ", string.format("%02X", rd[fecount + 10 + 5] - 0x33))
                        log.info(taskname, "DD: ", string.format("%02X", rd[fecount + 10 + 6] - 0x33))
                        log.info(taskname, "MM: ", string.format("%02X", rd[fecount + 10 + 7] - 0x33))
                        log.info(taskname, "YY: ", string.format("%02X", rd[fecount + 10 + 8] - 0x33))
                    end 
                    if i == 8 then 
                        log.info(taskname, "ss: ", string.format("%02X", rd[fecount + 10 + 5] - 0x33))
                        log.info(taskname, "mm: ", string.format("%02X", rd[fecount + 10 + 6] - 0x33))
                        log.info(taskname, "HH: ", string.format("%02X", rd[fecount + 10 + 7] - 0x33))
                    end 
                    if i == 9 then 
                        local hex_str_19 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                        local hex_str_20 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                        local hex_str_21 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                        local hex_str_22 = string.format("%02X", rd[fecount + 10 + 8] - 0x33)  
                        local concatenated_str =  hex_str_22 .. hex_str_21 .. hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        log.info(taskname, "t+pow decimal_value :", decimal_value )
                        --tpow = (decimal_value) * 0.01
                    end 
                    if i == 10 then 
                        local hex_str_19 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                        local hex_str_20 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                        local hex_str_21 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                        local hex_str_22 = string.format("%02X", rd[fecount + 10 + 8] - 0x33)  
                        local concatenated_str =  hex_str_22 .. hex_str_21 .. hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        log.info(taskname, "t-pow decimal_value :", decimal_value )
                        --tpow = (decimal_value) * 0.01
                    end 
                    if i == 11 or i == 12 then
                        local data_len = string.format("%02X", rd[fecount + 10])
                        log.info(taskname, "data_len:", data_len)
                        
                        if data_len == "01" then 
                            log.info(taskname, "Not support")
                        elseif data_len == "0C" then 
                            local hex_str_15 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                            local hex_str_16 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                            local hex_str_17 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                            local hex_str_18 = string.format("%02X", rd[fecount + 10 + 8] - 0x33)
                            local hex_str_19 = string.format("%02X", rd[fecount + 10 + 9] - 0x33)  
                            local hex_str_20 = string.format("%02X", rd[fecount + 10 + 10] - 0x33) 
                            local hex_str_21 = string.format("%02X", rd[fecount + 10 + 11] - 0x33)  
                            local hex_str_22 = string.format("%02X", rd[fecount + 10 + 12] - 0x33)   
                            
                            log.info(taskname, "YY: ", hex_str_22)
                            log.info(taskname, "MM: ", hex_str_21)
                            log.info(taskname, "DD: ", hex_str_20)
                            log.info(taskname, "HH: ", hex_str_19)
                            log.info(taskname, "mm: ", hex_str_18)
                            
                            local concatenated_str = hex_str_17 .. hex_str_16 .. hex_str_15
                            log.info(taskname, "concate str:", concatenated_str)
                        end
                    end
                    if i == 5 or i == 13 or i == 14 then
                        local hex_str_19 = string.format("%02X", rd[fecount + 15] - 0x33) 
                        local hex_str_20 = string.format("%02X", rd[fecount + 16] - 0x33)  
                        local concatenated_str = hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        if i == 5 then
                            log.info(taskname, "volt A decimal_value :", decimal_value )
                            volt = (decimal_value) * 0.1 
                        end
                        if i == 13 then
                            log.info(taskname, "volt B decimal_value :", decimal_value )
                        end
                        if i == 14 then
                            log.info(taskname, "volt C decimal_value :", decimal_value )
                        end
                    end
                    if i == 4 or i == 15 or i == 16 then
                        local hex_str_19 = string.format("%X", rd[fecount + 15] - 0x33) 
                        local hex_str_20 = string.format("%X", rd[fecount + 16] - 0x33)  
                        local hex_str_21 = string.format("%X", rd[fecount + 17] - 0x33)  
                        local concatenated_str = hex_str_21 .. hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        log.info(taskname, "current decimal_value :", decimal_value )
                        if i == 4 then
                            log.info(taskname, "curr A decimal_value :", decimal_value )
                            curr = (decimal_value) * 0.001 
                        end
                        if i == 15 then
                            log.info(taskname, "curr B decimal_value :", decimal_value )
                        end
                        if i == 16 then
                            log.info(taskname, "curr C decimal_value :", decimal_value )
                        end
                    end
                    if i == 3 or i == 17 or i == 18 or i == 19 or i == 20 or i == 21 or i == 22 or i == 23 then
                        local data_len = string.format("%02X", rd[fecount + 10])
                        log.info(taskname, "data_len:", data_len)
                        
                        if data_len == "01" then 
                            log.info(taskname, "Not support")
                        else 
                            local hex_str_19 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                            local hex_str_20 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                            local hex_str_21 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                            local concatenated_str =  hex_str_21 .. hex_str_20 .. hex_str_19
                            log.info(taskname, "concate str:", concatenated_str )
                            local decimal_value = tonumber(concatenated_str, 10)
                            if i == 4 then
                                pow = (decimal_value) * 0.0001
                                log.info(taskname, "pow decimal_value :", decimal_value )
                            end 
                            if i == 17 then
                                log.info(taskname, "pow A decimal_value :", decimal_value )
                            end 
                            if i == 18 then
                                log.info(taskname, "pow B decimal_value :", decimal_value )
                            end 
                            if i == 19 then
                                log.info(taskname, "pow C decimal_value :", decimal_value )
                            end 
                            if i == 20 then
                                log.info(taskname, "pow TT decimal_value :", decimal_value )
                            end 
                            if i == 21 then
                                log.info(taskname, "pow AA decimal_value :", decimal_value )
                            end 
                            if i == 22 then
                                log.info(taskname, "pow BB decimal_value :", decimal_value )
                            end 
                            if i == 23 then
                                log.info(taskname, "pow CC decimal_value :", decimal_value )
                            end 
                        end 
                    end
                    if i == 24 or i == 25 or i == 26 or i == 27 or i == 28 or i == 29 or i == 30 or i == 31 or i == 32 or i == 33 then 
                        local hex_str_19 = string.format("%02X", rd[fecount + 10 + 5] - 0x33)  
                        local hex_str_20 = string.format("%02X", rd[fecount + 10 + 6] - 0x33) 
                        local hex_str_21 = string.format("%02X", rd[fecount + 10 + 7] - 0x33)  
                        local hex_str_22 = string.format("%02X", rd[fecount + 10 + 8] - 0x33)  
                        local concatenated_str =  hex_str_22 .. hex_str_21 .. hex_str_20 .. hex_str_19
                        log.info(taskname, "concate str:", concatenated_str )
                        local decimal_value = tonumber(concatenated_str, 10)
                        if i == 24 then 
                            log.info(taskname, "t1+pow decimal_value :", decimal_value )
                            --tpow = (decimal_value) * 0.01
                        end 
                        if i == 25 then 
                            log.info(taskname, "t2+pow decimal_value :", decimal_value )
                        end 
                        if i == 26 then 
                            log.info(taskname, "t3+pow decimal_value :", decimal_value )
                        end 
                        if i == 27 then 
                            log.info(taskname, "t4+pow decimal_value :", decimal_value )
                        end 
                        if i == 28 then 
                            log.info(taskname, "t5+pow decimal_value :", decimal_value )
                        end 
                        if i == 29 then 
                            log.info(taskname, "t1-pow decimal_value :", decimal_value )
                        end 
                        if i == 30 then 
                            log.info(taskname, "t2-pow decimal_value :", decimal_value )
                        end 
                        if i == 31 then 
                            log.info(taskname, "t3-pow decimal_value :", decimal_value )
                        end 
                        if i == 32 then 
                            log.info(taskname, "t4-pow decimal_value :", decimal_value )
                        end 
                        if i == 33 then 
                            log.info(taskname, "t5-pow decimal_value :", decimal_value )
                        end 
                    end 
                end                     
            end 
        end 

        local d = {}
        d.imei = imei
        d.iccid = iccid
        d.serialNo = meterAddress
        d.datas = {}
        d.datas.temp1 = temp1
        d.datas.hum1 = hum1
        d.datas.curr = curr
        d.datas.volt = volt 
        d.datas.pow = pow
        d.datas.tpow = tpow
        local restr = json.encode(d)                            
        log.info(taskname, restr)
        if restr then 
            if 1 == pronet.PronetGetNetState(netid) then 
                pronet.PronetInsertSendChache(netid, restr)
                sys.publish(netmsg)
            end 
        end                         
        sys.wait(60000 * 15)
    end
end

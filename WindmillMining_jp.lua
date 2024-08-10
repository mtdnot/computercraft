-----基本的な動きの定義-----
function unitDig(n)
n = n or 1
    for i=1,4*n do        
        turtle.dig()
        turtle.forward()
    end
end

function unitForward(n)
n = n or 1
    for i=1,4 do
        turtle.forward()
    end
end

function outlineMining(n)
n = n or 1
    for i=1,4 do
        turtle.turnLeft()
        unitDig()
        turtle.turnLeft()
        turtle.turnLeft()
        unitForward()
        unitDig(2*n)
    end
end

--一週目の初期化関数--
function initialize()
    unitDig()
    turtle.turnRight()
    unitDig()
    outlineMining()
end
--n週目の再採掘
function repeatMining(n)
    turtle.turnRight()
    unitDig()
    outlineMining(n)
end

--角を何回曲がったかで何週目か判定する
--ただし、0週のとき、cout=1とコーディングしていることに注意
--前回までの掘った位置に移動する役割も含んでいる
function cornerNum()
    count = 1
    while turtle.detect()==false do
            unitForward()
            --目標地点にたどり着いていればここから下は無駄な動作になる
            turtle.turnRight()
            unitForward()
            turtle.turnLeft()
            count = count + 1
            print(count)
    end
    return count
end

--掘り終わった後にブロック設置で例外処理
--燃料で止まらないように計算と管理
--test関数とか作ってみる
--設計から見直し

function main()
    --移動と周回判定
    --初回
    cornerNum = cornerNum()
    if cornerNum ==1 then
        initialize()
        --端に移動
        turtle.turnLeft()
        unitForward()
        for i =2,3 do
            repeatMining(i)
            turtle.turnLeft()
            unitForward()
        end
    else
        --続きから
        for i = cornerNum,3 do
            repeatMining(i)
            turtle.turnLeft()
            unitForward()    
        end
    end
end


main()
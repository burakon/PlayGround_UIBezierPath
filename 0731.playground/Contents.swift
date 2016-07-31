
import UIKit
import XCPlayground
import Foundation


// iphone6と同じサイズのmyViewを作る
let myView:UIView = UIView(frame: CGRectMake(0,0,320,568))
myView.backgroundColor = UIColor.lightGrayColor()

//ここでUIColorを⌘clickしてみてください、「これってなんだ？」てやつがあったら⌘clickすると結構goodです


// Sliderを作成する.
let mySlider = UISlider(frame: CGRectMake(0, 0, myView.frame.width, 30))
mySlider.layer.position = CGPointMake(myView.frame.midX, 300)
mySlider.backgroundColor = UIColor.whiteColor()
mySlider.layer.cornerRadius = 10.0

// Sliderの最小値と最大値を設定する.
mySlider.minimumValue = 0
mySlider.maximumValue = 60

// Sliderのdefaultの値を設定する.
mySlider.value = 0

//最初に作ったmyViewに今作ったmySliderをのせる
myView.addSubview(mySlider)



//labelを作成する
var label = UILabel(frame: CGRectMake(0,100,myView.bounds.width,100))

//labelにかかれる文字を作成する（0になるようにする）
var sliderNum:Int = 0
//sliderNumはInt型ですが、labelに描画するためには文字にする必要があるためsliderNumStrをつくる
var sliderNumStr: String = String(sliderNum)

//labelの文字部分に先ほどStringに設定したsliderNumStrをいれる
label.text = sliderNumStr
label.font = UIFont.systemFontOfSize(80)
label.textAlignment = NSTextAlignment.Center
label.textColor = UIColor.whiteColor()  //見えればなんでもいいよ
label.backgroundColor = UIColor.magentaColor()  //見えればなんでもいいよ

//最初に作ったmyViewに今作ったlabelをのせる
myView.addSubview(label)



//波を描画するGenerativeViewをclassとしてつくる
class GenerativeView: UIView {
    
    var sliderValue:CGFloat = 30
    
    //GenerativeViewはUIViewを継承して作ったクラスになっていて、自作クラスです。
    //UIViewにそもそもある drawRectという描画に使う関数(func)をこちらで上書き(override)してこちらで勝手に描画できるようにしましょう
    override func drawRect(rect: CGRect) {
        
        
        UIColor.magentaColor().setFill() //　波の背景にあたる部分の色を決める
        UIRectFill(bounds) //　bounds = GenerativeView内すべて
        UIColor.lightGrayColor().setFill() //　波にあたる下の部分の色を決める
        
        
        //全体の稼働距離を、GenerativeView の横幅−80にする
        let moveWidth = self.frame.width - 80
        
        //1動いた時の稼働距離を、GenerativeView の横幅−80の60分の1にする
        let oneMove = moveWidth / 60
        
        
        
        /* UIBezierPathとは
         直線や曲線を描くために使うclassです
         */
        
        
        // <<直線をかく>> 算数は苦手なので頑張りましたが変なコードだと思います
        //5つポイントを書いています
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: self.frame.height * 0.8 - (60 - sliderValue)))
        path.addLineToPoint(CGPoint(x: 20 + (sliderValue * oneMove),y: self.frame.height * 0.15))
        path.addLineToPoint(CGPoint(x: 40 + (sliderValue * oneMove),y: self.frame.height * 0.1))
        path.addLineToPoint(CGPoint(x: 40 + (sliderValue * oneMove),y: self.frame.height))
        path.addLineToPoint(CGPoint(x: 0, y: self.frame.height))
        path.fill()
        
        //右半分を描画
        //上のコードを反転させて描くために、２つのUIBezierPathを描いています
        let rightPath = UIBezierPath()
        rightPath.moveToPoint(CGPoint(x: self.frame.width, y: self.frame.height*0.8-sliderValue))
        rightPath.addLineToPoint(CGPoint(x: self.frame.width-20 - ((60-sliderValue) * oneMove),y: self.frame.height*0.15))
        rightPath.addLineToPoint(CGPoint(x: (self.frame.width-40 - ((60-sliderValue) * oneMove))-2,y: self.frame.height*0.1))
        rightPath.addLineToPoint(CGPoint(x: (self.frame.width-40 - ((60-sliderValue) * oneMove))-2,y: self.frame.height))
        rightPath.addLineToPoint(CGPoint(x: self.frame.width, y: self.frame.height))
        rightPath.fill()
        
        
        
        
        // <<曲線をかく>>
        
        /* controlPointて急に出てきたけど何？？？
         =>　曲がり具合を決める制御点（説明にはちょっと時間がかかるから、コードを読んでみたりいじってみたりして各自理解をふかめてね ＾q＾）*/
        
        //左半分を描画
        //        let path = UIBezierPath()
        //        path.moveToPoint(CGPoint(x: 0, y: self.frame.height * 0.8 - (60 - sliderValue)))
        //        path.addQuadCurveToPoint(CGPoint( x: 20 + (sliderValue * oneMove),y: self.frame.height * 0.15),
        //                                 controlPoint: (CGPoint( x: 20-(20 * (1-sliderValue/60)), y:self.frame.height * 0.9 - (60 - sliderValue ))))
        //        path.addQuadCurveToPoint(CGPoint(x: 40 + (sliderValue * oneMove),y: self.frame.height*0.1),
        //                                 controlPoint: CGPoint(x: 30 + (sliderValue * oneMove),y: self.frame.height*0.1))//頂点
        //        path.addLineToPoint(CGPoint(x: 40 + (sliderValue * oneMove),y: self.frame.height))
        //        path.addLineToPoint(CGPoint(x: 0, y: self.frame.height))
        //        path.fill()
        //
        //        //右半分を描画
        //        let rightPath = UIBezierPath()
        //        rightPath.moveToPoint(CGPoint(x: self.frame.width, y: self.frame.height*0.8-sliderValue))
        //        rightPath.addQuadCurveToPoint(CGPoint(x: self.frame.width-20 - ((60-sliderValue) * oneMove),y: self.frame.height*0.15),
        //                                      controlPoint: CGPoint(x: self.frame.width-(20 - 20 * sliderValue / 60), y: self.frame.height*0.9 - sliderValue))
        //        rightPath.addQuadCurveToPoint(CGPoint(x: (self.frame.width-40 - ((60-sliderValue) * oneMove))-2,y: self.frame.height*0.1),
        //                                      controlPoint: CGPoint(x: self.frame.width-30 - ((60-sliderValue) * oneMove),y: self.frame.height*0.1))//頂点
        //        rightPath.addLineToPoint(CGPoint(x: (self.frame.width-40 - ((60-sliderValue) * oneMove))-2,y: self.frame.height))
        //        rightPath.addLineToPoint(CGPoint(x: self.frame.width, y: self.frame.height))
        //        rightPath.fill()
        
        
    }
    
}


//GenerativeViewをもとにpathViewをつくる

let pathView:GenerativeView = GenerativeView(frame: CGRectMake(0,myView.frame.height-80,320,80))

myView.addSubview(pathView)



//ここで出てくる突然のモードという変数、でも安心してくださいこわいもんじゃありません
//このmodeによってsliderの値をプラスしていくかマイナスしていくかを決める材料としてつかいます
//defaultはtrueに。
var mode = true

func moveSlider() {
    
    switch mode {
        
    //mode が true　の場合
    case true:
        if sliderNum == 60 {
            // sliderが60になっていたら
            mode = false
            break
        }
        sliderNum = sliderNum+1
        sliderNumStr = String(sliderNum)
        label.text = sliderNumStr
        mySlider.value = Float(sliderNum)
        
        
    case false:
        //mode が false の場合
        if sliderNum == 0 {
            // sliderが0になっていたら
            mode = true
            break
        }
        sliderNum = sliderNum-1
        sliderNumStr = String(sliderNum)
        label.text = sliderNumStr
        mySlider.value = Float(sliderNum)
    }
    
    myView
    pathView.sliderValue =  CGFloat(sliderNum)
    
    //ここでView出してくれるとヌルヌル動きます
    pathView.setNeedsDisplay()
    
    
    
}

// 無限実行フラグを有効にして、タイマーが動くようにする
//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//
//class MyTimer: NSTimer {
//    func startTimer() {
//        //0.5秒ごとに自分の onTimer というメソッドを呼ぶようにする
//        NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: #selector(MyTimer.onTimer), userInfo: nil, repeats: true)
//    }
//
//    func onTimer() {
//        let today = NSDate()
//        print("now - \(today) ")
//
//        //sliderの値を変えるメソッドを実行
//        moveSlider()

//ここで描画させてみよう！
//        myView.setNeedsDisplay()
//    }
//}
//
//
////上でつくったMyTimerクラスをもとにmyTimerをつくって、ずっとstartTierする
//var myTimer = MyTimer()
//myTimer.startTimer()
//XCPlaygroundPage.currentPage.liveView = myView

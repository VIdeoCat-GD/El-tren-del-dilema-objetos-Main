package;

import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.Assets;
import openfl.display.Shape;
import openfl.filters.GlowFilter;
import openfl.display.Bitmap;
import openfl.ui.Keyboard;
import openfl.events.Event;
import openfl.text.TextFieldType;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;

class InputBox extends Sprite {
    public var input:TextField;

    public function new(w:Int, h:Int) {
        super();

        // Fondo
        var bg:Shape = new Shape();
        bg.graphics.beginFill(0xEEEEEE);
        bg.graphics.lineStyle(2, 0x000000);
        bg.graphics.drawRect(0, 0, w, h);
        bg.graphics.endFill();
        addChild(bg);

        // Campo de texto
        input = new TextField();
        input.type = TextFieldType.INPUT;
        input.width = w - 10;
        input.height = h - 10;
        input.x = 5;
        input.y = 5;
        input.multiline = false;
        input.border = false;

        var format = new TextFormat("Arial", 20, 0x000000);
        input.defaultTextFormat = format;
        input.text = "";

        addChild(input);
    }
}

class Button extends Sprite {
    public var label:TextField;

    public function new(text:String, w:Int = 200, h:Int = 60) {
        super();

        buttonMode = true;
        mouseChildren = false;

        // Fondo
        var bg:Shape = new Shape();
        bg.graphics.beginFill(0x000000);
        bg.graphics.drawRoundRect(0, 0, w, h, 12);
        bg.graphics.endFill();
        addChild(bg);

        // Texto
        label = new TextField();
        label.width = w;
        label.height = h;
        label.selectable = false;
        label.mouseEnabled = false;

        var format = new TextFormat("Arial", 24, 0xFFFFFF);
        format.align = "center";

        label.defaultTextFormat = format;
        label.text = text;

        label.y = (h - label.textHeight) / 2 - 2;
        addChild(label);

        // Efectos hover
        addEventListener(MouseEvent.MOUSE_OVER, function(_) {
            bg.alpha = 0.8;
        });

        addEventListener(MouseEvent.MOUSE_OUT, function(_) {
            bg.alpha = 1;
        });
    }
}

class Main extends Sprite {
    var text1:TextField = new TextField();
    var text2:TextField = new TextField();
    var texttuto:TextField = new TextField();
    var text1C:TextField = new TextField();
    var text2C:TextField = new TextField();

    var glow:GlowFilter = new GlowFilter(0x000000, 2, 2, 2, 20, 1, true, false);

    var buttonR:Button = new Button("Reiniciar (R)", 200, 60);
    var buttonC:Button = new Button("Modificadores (false)", 400, 60);
    var trenbonito = new Bitmap(Assets.getBitmapData("assets/images/trenbonito.png"));
    var fondo = new Bitmap(Assets.getBitmapData("assets/images/fondo.png"));

    var speed:Float = 0;
    var modificadores:Bool = false;
    var direction:Int = 0;
    public function new() {
        stage.scaleMode = "noScale";
        stage.align = "topLeft";
        super();
        buttonR.x = 500;
        buttonR.y = 0;
        buttonC.x = 800;
        buttonC.y = 0;
        // Añadir a la pantalla
        addChild(fondo);
        addChild(text1);
        addChild(text2);
        addChild(text1C);
        addChild(text2C);
        addChild(trenbonito);
        addChild(buttonC);
        addChild(buttonR);
        addChild(texttuto);

        buttonR.addEventListener(MouseEvent.CLICK, function(_) {
            levelnew();
        });
        buttonC.addEventListener(MouseEvent.CLICK, function(_) {
            if (modificadores == false) {
                modificadores = true;
                buttonC.label.text = "Modificadores (true)";
            } else {
                modificadores = false;
                buttonC.label.text = "Modificadores (false)";
            }
        });

        levelnew();

		addEventListener(Event.ENTER_FRAME, update);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }
	function update(e:Event):Void {
		trenbonito.x += speed;
        if (direction == 1) {
            trenbonito.y = 350;
        }
        if (direction == -1) {
            trenbonito.y = 705;
        }
        if (trenbonito.x > 1500) {
            speed = 0;
        }
        if (trenbonito.x > 510) {
            if (direction == 1) {
                text1.width = 0;
                text1.height = 0;
            }
            if (direction == -1) {
                text2.width = 0;
                text2.height = 0;
            }
        }
        if (trenbonito.x > 1110) {
            if (direction == 1) {
                text1C.width = 0;
                text1C.height = 0;
            }
            if (direction == -1) {
                text2C.width = 0;
                text2C.height = 0;
            }
        }
	}
    function onKeyDown(e:KeyboardEvent):Void {
        if (direction == 0) {
            if (e.keyCode == Keyboard.UP) {
                direction = 1;
                speed = 17;
                trenbonito.visible = true;
            }
            else if (e.keyCode == Keyboard.DOWN) {
                direction = -1;
                speed = 17;
                trenbonito.visible = true;
            }
        }
        if (e.keyCode == Keyboard.R) {
            levelnew();
        }
    }
    function levelnew() {
        direction = 0;
        trenbonito.visible = false;
        speed = 0;
        direction = 0;
        trenbonito.x = -900;
        text1.width = 600;
        text1.height = 300;
        text2.width = 600;
        text2.height = 300;
        text1C.width = 600;
        text1C.height = 100;
        text2C.width = 600;
        text2C.height = 100;
        text1C.x = 1200;
        text2C.x = 1200;
        text1C.y = text1.y;
        text2C.y = text2.y;
        texttuto.x = 600;
        texttuto.y = 550;
        texttuto.width = 800;
        texttuto.height = 100;

        var randomNum = Math.floor(Math.random() * 21);
        switch (randomNum) {
            case 0: text1.text = "Una objeto que no has visto nunca";
            case 1: text1.text = "un peluche gigante";
            case 2: text1.text = "Un objeto perdido";
            case 3: text1.text = "Un peluche pequeño que te va a ser millonario";
            case 4: text1.text = "El tiquet que tiene el gran premio de la lotería";
            case 5: text1.text = "Un peluche que lo abandonaron en la calle";
            case 6: text1.text = "Una piedra que brilla en la oscuridad";
            case 7: text1.text = "Todos los servidores de Inteligencia Artificial";
            case 8: text1.text = "Un objeto tegnologico que es del futuro";
            case 9: text1.text = "Tu lugar favorito en el mundo";
            case 10: text1.text = "El objeto mas raro que has visto la nasa";
            case 11: text1.text = "Unas Gafas de realidad virtual avanzadas";
            case 12: text1.text = "Un a bola de los deseos que concede 3 deseos";
            case 13: text1.text = "Un teletransportador personal";
            case 14: text1.text = "Una piedra chef famoso que cocina platos exquisitos";
            case 15: text1.text = "Un peluche olímpico que es generoso con tu amor";
            case 16: text1.text = "Un robot de peluche que comparte el amor";
            case 17: text1.text = "Unos Cascos que esta en un tesoro";
            case 18: text1.text = "Un movil de la suerte";
            case 19: text1.text = "Un pen que tiene la peli de regreso al futuro 4";
            case 20: text1.text = "Tu libro favorito";
        }

        randomNum = Math.floor(Math.random() * 21);
        switch (randomNum) {
            case 0: text2.text = "Una objeto que no has visto nunca";
            case 1: text2.text = "un peluche gigante";
            case 2: text2.text = "Un objeto perdido";
            case 3: text2.text = "Un peluche pequeño que te va a ser millonario";
            case 4: text2.text = "El tiquet que tiene el gran premio de la lotería";
            case 5: text2.text = "Un peluche que lo abandonaron en la calle";
            case 6: text2.text = "Una piedra que brilla en la oscuridad";
            case 7: text2.text = "Todos los servidores de Inteligencia Artificial";
            case 8: text2.text = "Un objeto tegnologico que es del futuro";
            case 9: text2.text = "Tu lugar favorito en el mundo";
            case 10: text2.text = "El objeto mas raro que has visto la nasa";
            case 11: text2.text = "Unas Gafas de realidad virtual avanzadas";
            case 12: text2.text = "Un a bola de los deseos que concede 3 deseos";
            case 13: text2.text = "Un teletransportador personal";
            case 14: text2.text = "Una piedra chef famoso que cocina platos exquisitos";
            case 15: text2.text = "Un peluche olímpico que es generoso con tu amor";
            case 16: text2.text = "Un robot de peluche que comparte el amor";
            case 17: text2.text = "Unos Cascos que esta en un tesoro";
            case 18: text2.text = "Un movil de la suerte";
            case 19: text2.text = "Un pen que tiene la peli de regreso al futuro 4";
            case 20: text2.text = "Tu libro favorito";
        }

        trenbonito.y = 450;
        trenbonito.width = 360;
        trenbonito.height = 105;
        text1.x = 500;
        text2.x = 500;
        text1.y = 380;
        text2.y = 750;
        trace("Modificadores: " + modificadores);
        if (modificadores == true) {
            randomNum = Math.floor(Math.random() * 21);
            switch (randomNum) {
                case 0: text1C.text = "Modificador: Sera multimillonario"; 
                case 1: text1C.text = "Modificador: Tiene una enfermedad terminal";
                case 2: text1C.text = "Modificador: Sera tu esposa ideal";
                case 3: text1C.text = "Modificador: Tiene un Kimono y te lo dara";
                case 4: text1C.text = "Modificador: Es un artista reconocido";
                case 5: text1C.text = "Modificador: Te va a dar un objeto raro que vale mucho";
                case 6: text1C.text = "Modificador: Te dara una casa gratis";
                case 7: text1C.text = "Modificador: Sera tu mejor amigo";
                case 8: text1C.text = "Modificador: Te hara famoso en internet";
                case 9: text1C.text = "Modificador: Te dara poderes magicos";
                case 10: text1C.text = "Modificador: Te hara vivir una aventura increible";
                case 11: text1C.text = "Modificador: Te hara encontrar el amor verdadero";
                case 12: text1C.text = "Modificador: Es un experto en tecnologia";
                case 13: text1C.text = "Modificador: Descubro un nuevo material superresistente";
                case 14: text1C.text = "Modificador: Te hara un gran invento";
                case 15: text1C.text = "Modificador: Te llevara a un lugar secreto";
                case 16: text1C.text = "Modificador: Te dara una mascota unica";
                case 17: text1C.text = "Modificador: Es un chef famoso";
                case 18: text1C.text = "Modificador: Te hara un regalo inesperado";
                case 19: text1C.text = "Modificador: Te hara descubrir un talento oculto";
                case 20: text1C.text = "Modificador: Te hara ganar un premio importante";
            }
            randomNum = Math.floor(Math.random() * 21);
            switch (randomNum) {
                case 0: text2C.text = "Modificador: Tiene la cura contra el sida y cancer";
                case 1: text2C.text = "Modificador: Te hara muy feliz";
                case 2: text2C.text = "Modificador: Te dara superpoderes";
                case 3: text2C.text = "Modificador: Te dara dinero para no trabajar";
                case 4: text2C.text = "Modificador: Seras un buen Vtuber con el";
                case 5: text2C.text = "Modificador: Tendras lo que as querido tener en tu vida";
                case 6: text2C.text = "Modificador: Te llevara a lugares increibles";
                case 7: text2C.text = "Modificador: Te dara una vida larga y feliz";
                case 8: text2C.text = "Modificador: Te hara inmortal";
                case 9: text2C.text = "Modificador: Seras millonario";
                case 10: text2C.text = "Modificador: Sabras el secreto del gobierno";
                case 11: text2C.text = "Modificador: Tendras un robot sirviente";
                case 12: text2C.text = "Modificador: Te hara un gran invento";
                case 13: text2C.text = "Modificador: Es un experto en timos y te ayudara a hacer uno";
                case 14: text2C.text = "Modificador: Te hara famoso en la cocina";
                case 15: text2C.text = "Modificador: Te dara un objeto tecnologico avanzado";
                case 16: text2C.text = "Modificador: Te hara encontrar un tesoro escondido";
                case 17: text2C.text = "Modificador: Te hara un gran descubrimiento cientifico";
                case 18: text2C.text = "Modificador: Sera tu mallordomo en el futuro";
                case 19: text2C.text = "Modificador: Te hara vivir una experiencia unica";
                case 20: text2C.text = "Modificador: Te hara conocer a una persona importante";
        }
        } else {
            text1C.text = "";
            text2C.text = "";
        }

        var formatodetexto:TextFormat = new TextFormat();
        formatodetexto.size = 20;
        formatodetexto.color = 0xFFFFFF;
        formatodetexto.bold = true;
        formatodetexto.align = "center";

        text1.setTextFormat(formatodetexto);
        text2.setTextFormat(formatodetexto);
        text1C.setTextFormat(formatodetexto);
        text2C.setTextFormat(formatodetexto);

        text1.filters = [glow];
        text2.filters = [glow];
        text1C.filters = [glow];
        text2C.filters = [glow];
        texttuto.text = "Usa las flechas ARRIBA y ABAJO para elegir una via y avanzar con el tren.";
        texttuto.setTextFormat(formatodetexto);
        texttuto.filters = [glow];
    }
}
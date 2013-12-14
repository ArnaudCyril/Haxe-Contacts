package;

//on importe les classes qui nous sont utiles
// les classes de type nme
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.MouseEvent;
import nme.text.TextFormat;
import nme.text.TextField;
import nme.text.TextField.TextField;
import nme.Assets;
import nme.Lib;
import nme.filesystem.File; 
import nme.text.TextFieldAutoSize;
import nme.text.TextFieldType;
import nme.display.Stage;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Rectangle;
import nme.events.TouchEvent;
// les classes de type android (windows , android...)
import cpp.Lib;
import cpp.Sys;
import cpp.db.Connection;
import cpp.db.Sqlite;
import cpp.FileSystem;
import cpp.io.File;
import cpp.db.ResultSet;
//on importe la classe créée : ButtonTrial
import ButtonTrial;

//Debut de la classe principale du projet : je l'ai appelé Contacts
class Contacts extends Sprite {
	
	//declaration des variables "globales" de la classe Contacts
	//declaration des variables , comme il n'y a qu'un classe on els déclare comme private
	private var _freshButton:ButtonTrial;
	private var AjoutBande :ButtonTrial;
	private var OptionBande :ButtonTrial;
	private var MainBande:ButtonTrial;
	private var ButtonSuprr:ButtonTrial;
	private var ButtonModif:ButtonTrial;
	private var ButtonAllSuprr:ButtonTrial;
	private var LigneContact:ButtonTrial;
	private var ButtonGoEdit:ButtonTrial;
	private var ButtonBackmain:ButtonTrial;
	private var Id:Int;
	private var debugNom: String;
	private var debugNumero: String;
	private var debugPrenom: String;
	private var freshButton2:ButtonTrial;
	private var rechercheT:TextField;
	private var text:String;
	private var rect3:Sprite;
	private var rect:Sprite ;
	private var MouseYStart:Float;
	private var nomMain:String;
	
	
//fonction qui se lance au debut et qui appelle les fonction initialize et begin	
public function new () {
		
		super();
		initialize();
		begin("","");
	}
	
private function begin (text:String,recherche:String) {
	
		ClearScreen();// on (re)initialize l'ecran
		Scroll();// on crée un zone de scroll pour voir ses contacts
		CreateBande(1, 2, 0);//on créé la bande de navigation du haut
		initialize();//on réinitialize certains parametres
		
		var  num : Int =  0;
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 22, 0xdddddd);//definition d'un police , couleur , taille de texte...
		
		
		
		var TextAffiche = new TextField();					//creation d'un champ texte
				TextAffiche.defaultTextFormat = format;		//on lui affecte la police (voir format)
				TextAffiche.width = 500;					//la largeur du champ(en px)
				TextAffiche.selectable = false;				//pas selectionnable
				TextAffiche.height = 40;					//la hauteur de champ
				TextAffiche.x = 20;							//la coordonées horizontale du champ
				TextAffiche.y = 250;						//la coordonées verticale du champ
				TextAffiche.text = text;					//on lui affecte du texte(string)
				addChild(TextAffiche);						//on ajoute ce champ a l'application
				
		format = new TextFormat (font.fontName, 36, 0xdddddd);	//redefinition de la police
		
		var GeneralText = new TextField();
				GeneralText.defaultTextFormat = format;
				GeneralText.width = 500;
				GeneralText.selectable = false;
				GeneralText.height = 40;
				GeneralText.x = 50;
				GeneralText.y = 65;
				GeneralText.text = "Liste de vos contact(s)";
				addChild(GeneralText);
				
		format = new TextFormat (font.fontName, 22, 0x888888);	
		var Recherche = new TextField();
				Recherche.defaultTextFormat = format;
				Recherche.width = 500;
				Recherche.selectable = false;
				Recherche.height = 40;
				Recherche.x = 50;
				Recherche.y = 125;
				Recherche.text = "Rechecher un contact";
				addChild(Recherche);
				
		format = new TextFormat (font.fontName, 36, 0xdddddd);
	
			rechercheT = this.addText(recherche, 0x6C7BB8,40,165);//creation d'un container de type imput (voir classe addText)
			rechercheT.addEventListener (Event.CHANGE, Recherche_OnChange); //ajout d'un evenement declancheur sur l'objet
			
			this.addChild(rechercheT); 
			rechercheT.autoSize;
			if (recherche != "") // si l'utilisateur a rentré un champ dans la barre de recherche , le clavier virtuel reste actif
			{
			stage.focus = rechercheT;
			}
	
		
		
		//creation/connexion a la base de donéne Contacts dans le repertoire dedié a cela
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
		
		//creation d'un table 
		
		connection.request("CREATE TABLE IF NOT EXISTS Contact (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, number TEXT)"); 
		
		//insertion de données 
		//connection.request("INSERT INTO Contact (name,number) VALUES ('Gilles','0684590198')");
	
		//affichage d'un requette
		var rset = connection.request("SELECT * FROM Contact where name like '"+recherche+"%' order by name");
		//selection de tous les contacts avec recherche eventuelle
		
			for ( row in rset ) {
				var decal = 80 * num;
				var id : Int;
				var Contact = new TextField();
				Contact.defaultTextFormat = format;
				Contact.width = 500;
				Contact.selectable = false;
				Contact.height = 50;
				Contact.x = 30;
				Contact.y = 20+ decal;
				id = row.id;
				Contact.text = (row.name);//on ajoute le nom du contact
				
				
				LigneContact = new ButtonTrial(cast(Lib.current.stage.stageWidth , Float), 76.0,0x061B6B);
				LigneContact.x = cast(Lib.current.stage.stageWidth, Float) / 2;
				LigneContact.name = "bleu"+Std.string(id);
				LigneContact.y = 40+ decal;
				rect.addChild(LigneContact);//rect est la zone de scroll crée précedemment , on ajoute des elements a cette zone
				rect.addChild(Contact);
				// ajoute un fonc , ca fait plus joli ! 
				
				ButtonGoEdit = new ButtonTrial(50.0, 50.0,0x3FBBE0); //on ajoute un boutton
				ButtonGoEdit.x = cast(Lib.current.stage.stageWidth, Float)-100; // coordonnées x 
				ButtonGoEdit.y =37+decal; // coordonnées y
				rect.addChild(ButtonGoEdit); //rect est la zone de scroll crée précedemment , on ajoute des elements a cette zone
				ButtonGoEdit.MouseDown = DownHappenedSelected;//ajout d'un évenement déclancheur
				ButtonGoEdit.name = Std.string(id);
				
				var GoEditText = new TextField();
				
				GoEditText.width = 100;
				GoEditText.defaultTextFormat = format;
				GoEditText.selectable = false;
				GoEditText.height = 100;
				GoEditText.x = ButtonGoEdit.x - 19;
				GoEditText.y = ButtonGoEdit.y - 25;
				GoEditText.text = "+";
				GoEditText.name = Std.string(id);
				GoEditText.addEventListener(TouchEvent.TOUCH_END, DownHappenedSelected);//ajout d'un évenement déclacheur
		
				rect.addChild(GoEditText);
			
				num++;
			}
			if (num == 0 && recherche=="") // si il n'y a pas de contacts du tout on affiche un message
			{
				format = new TextFormat (font.fontName, 26, 0xffffff);
				var MessagePasDeContact = new TextField();
				MessagePasDeContact.width = cast(Lib.current.stage.stageWidth , Float);
				MessagePasDeContact.defaultTextFormat = format;
				MessagePasDeContact.selectable = false;
				MessagePasDeContact.height = 400;
				MessagePasDeContact.x =5;
				MessagePasDeContact.y = 320;
				MessagePasDeContact.text = "Vous n'avez pas encore de contact\r\nVous pouvez en ajouter en allant\r\nsur Ajouter en haut a gauche ";
				
				
		
				addChild(MessagePasDeContact);
			}
			if (num == 0 && recherche!="") // si il n'y a pas de contact suite a un recherche on affiche aussi un message
			{
				format = new TextFormat (font.fontName, 26, 0xffffff);
				var MessagePasDeContact2 = new TextField();
				MessagePasDeContact2.width = cast(Lib.current.stage.stageWidth , Float);
				MessagePasDeContact2.defaultTextFormat = format;
				MessagePasDeContact2.selectable = false;
				MessagePasDeContact2.height = 400;
				MessagePasDeContact2.x =5;
				MessagePasDeContact2.y = 320;
				MessagePasDeContact2.text = "Aucun contact trouvé";
				
				
		
				addChild(MessagePasDeContact2);
			}
			
		connection.close();

		//fin de la connexion


}
private function Scroll():Void {

	
	var font = Assets.getFont ("assets/VeraSe.ttf");
	var format = new TextFormat (font.fontName, 24, 0xffffff);
	
	rect = new Sprite();
	//on déclare un nouveau sprite
	
			rect.graphics.beginFill(0x111111); // la couleur
			
						
			rect.graphics.drawRect(0,0,cast(Lib.current.stage.stageWidth , Float),800); // on créé un rectangle 
			rect.scrollRect = new Rectangle(0,0,cast(Lib.current.stage.stageWidth , Float),800); // un rectangle qui sera la zone de scroll
			var rect2:Rectangle = rect.scrollRect;
			rect2.y -= 300;
			rect.scrollRect = rect2;//on le baisse pour afficher autre chose dessus (mettre 300) dans la coordonnée y ne marchait pas..)
			addChild(rect);
			rect.addEventListener(TouchEvent.TOUCH_BEGIN, Start);//ajout d'évenements déclancheurs
			rect.addEventListener(TouchEvent.TOUCH_END, Stop);
				

			rect3 = new Sprite(); // creation d'un zone en haut pour contenir les infos de la page principale 
			rect3.graphics.beginFill(0x000000);
			rect3.graphics.drawRect(0,0,cast(Lib.current.stage.stageWidth , Float),300);
			addChild(rect3);
				
			
}
function Start(event:TouchEvent):Void {
	 MouseYStart = mouseY;
	//on enregistre la postion y du debut de touché
}
function Stop(event:TouchEvent):Void {
		var MouseYStop = mouseY; //la position du y a la fin du touché 
		var i = 0;
		var vitesse  = (MouseYStart - MouseYStop); // clacul de la distance
		if (vitesse < 0)
		{
			vitesse = -(vitesse); // obtention de la valeur absolue de la distance
		}
	
		if (MouseYStart < MouseYStop)//on veut monter
		{
			if (rect.getChildAt(0).y < 40) // si on est pas deja en haut
				{
			
				while (i < rect.numChildren)
						{
						rect.getChildAt(i).y += Math.floor(vitesse/100)*40; // on decalde les element vers le bas pour afficher ceux qui sont plus haut
						i++;
						
						}
				}
				
		}
		if (MouseYStart > MouseYStop)//on veut descendre
		{
			if (rect.getChildAt(rect.numChildren-3).y >450)  // si on est pas deja en bas
				{
				while (i < rect.numChildren)
							{
								rect.getChildAt(i).y -=  Math.floor(vitesse / 100) * 40;
								
							
								i++;
						
							}
				}
		}
		
				

}
private function CreateBande(param1:Int, param2:Int, param3:Int):Void {
	//creation de la bande menu du haut
	var font = Assets.getFont ("assets/VeraSe.ttf");
	var format = new TextFormat (font.fontName, 24, 0x000000);
	
	//le texte du menu
	var Text1 = new TextField();
				Text1.defaultTextFormat = format;
				Text1.width = 500;
				Text1.selectable = false;
				Text1.height = 40;
				Text1.x = 70;
				Text1.y = 10;
	var Text2 = new TextField();
				Text2.defaultTextFormat = format;
				Text2.width = 500;
				Text2.selectable = false;
				Text2.height = 40;
				Text2.x = 80+cast(Lib.current.stage.stageWidth, Float) / 2-10;
				Text2.y = 10;
	var Text3 = new TextField();
				Text3.defaultTextFormat = format;
				Text3.width = 500;
				Text3.selectable = false;
				Text3.height = 40;
				Text3.x = 30+cast(Lib.current.stage.stageWidth, Float) / 2-10;
				Text3.y = 10;

// selon la combinaison on affiche differentes conbinaisons avec le texte associé et aux bonne coordonnées
// legende 1 = Ajouter 
//		   2 = Options
//         3 = Accueil

if(param1 == 1 && param2 == 2)//ajout et option
{
//appel de la fonction qui crée la partie de la bande "Ajout" aux coordonnées ci dessous
Text1.text = OnAjout(cast(Lib.current.stage.stageWidth, Float) / 4 , cast(Lib.current.stage.stageWidth, Float) / 2);
//ajout d'un element declancheur
Text1.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedGoAjout);
//ajout a l'application
addChild(Text1);

Text2.text=OnOption(cast(Lib.current.stage.stageWidth, Float) / 4 + cast(Lib.current.stage.stageWidth, Float) / 2 + 5,cast(Lib.current.stage.stageWidth, Float)/2);
Text2.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedOption);
addChild(Text2);

}
if(param1==3 && param2 == 2)// accueil et options
{
Text1.text = OnMain(cast(Lib.current.stage.stageWidth, Float) / 4 , cast(Lib.current.stage.stageWidth, Float)/2);
Text1.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedReturnMain);
addChild(Text1);

Text2.text=OnOption(cast(Lib.current.stage.stageWidth, Float) / 4 + cast(Lib.current.stage.stageWidth, Float) / 2 + 5,cast(Lib.current.stage.stageWidth, Float)/2);
Text2.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedOption);
addChild(Text2);
}
if(param1 == 3 && param2==1 && param3==2)// acceuil , ajout et options
{
//bande a 3 composant cette fois 
Text1.text = OnMain(cast(Lib.current.stage.stageWidth, Float) / 6,cast(Lib.current.stage.stageWidth, Float)/3);
Text1.x = cast(Lib.current.stage.stageWidth, Float) / 6-50;

Text1.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedReturnMain);
addChild(Text1);

Text2.text = OnAjout(cast(Lib.current.stage.stageWidth, Float) / 6 + cast(Lib.current.stage.stageWidth, Float) / 3 + 5,cast(Lib.current.stage.stageWidth, Float)/3);
Text2.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedGoAjout);
Text2.x = cast(Lib.current.stage.stageWidth, Float) / 2 - 40;
addChild(Text2);

Text3.text=OnOption(cast(Lib.current.stage.stageWidth, Float) / 6 + cast(Lib.current.stage.stageWidth, Float) / 1.5 + 10,cast(Lib.current.stage.stageWidth, Float)/3);
Text3.x = cast(Lib.current.stage.stageWidth, Float) * 2 / 3+35;
Text3.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedOption);
addChild(Text3);
	
}
if(param1 == 3 && param2 == 1 && param3!=2) // acceuil et ajout
{
	Text1.text = OnMain(cast(Lib.current.stage.stageWidth, Float) / 4 ,cast(Lib.current.stage.stageWidth, Float)/2);
Text1.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedReturnMain);
addChild(Text1);	

Text2.text = OnAjout(cast(Lib.current.stage.stageWidth, Float) / 4 + cast(Lib.current.stage.stageWidth, Float) / 2 + 5,cast(Lib.current.stage.stageWidth, Float)/2);
Text2.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedGoAjout);
addChild(Text2);
	
	
}

	
}
private function OnMain(x:Float, w:Float ):String {
		//fonction permettant la creation de la partie de la bande "Accueil" qui prend a parametres le postion horizontale et la largeur
		var width:Float;
		width = w;
		MainBande = new ButtonTrial(width, 50.0,0x6C7BB8);
	
		this.addChild(MainBande);
		MainBande.x = x;
		MainBande.y = 25;

		MainBande.MouseDown = DownHappenedReturnMain; // au clic on va sur la page d'accueil
		
		return("Accueil");
}
private function OnAjout(x:Float,w:Float):String {
//fonction permettant la creation de la partie de la bande "Ajouter" qui prend a parametres le postion horizontale et la largeur

		var width:Float;
		width= w;
		AjoutBande = new ButtonTrial(width, 50.0,0x6C7BB8);

		this.addChild(AjoutBande );
		AjoutBande.x = x;
		AjoutBande.y = 25;
		AjoutBande.MouseDown = DownHappenedGoAjout;// au clic on va sur la page d'ajout
		return("Ajouter");
		
}
private function OnOption(x:Float,w:Float):String {
//fonction permettant la creation de la partie de la bande "Option" qui prend a parametres le postion horizontale et la largeur

		
		OptionBande = new ButtonTrial(w, 50.0,0x6C7BB8);

		this.addChild(OptionBande );
		OptionBande.x = x;
		OptionBande.y = 25;

		OptionBande.MouseDown = DownHappenedOption;// au clic on va sur la page d'options
		return("Options");
}


private function Name_onChange (event:Event):Void {
	//des qu'il y a un changement dans l'imput , on actualise le nom
	var nom:TextField = event.currentTarget;
	debugNom = nom.text;
	
}

private function Number_onChange (event:Event):Void {
		//des qu'il y a un changement dans l'imput , on actualise le numero
 var numero:TextField = event.currentTarget;
	debugNumero = numero.text;
	
}
private function Recherche_OnChange (event:Event):Void {
	
		//des qu'il y a un changement dans l'imput, on actualise le critere
var recherche:TextField = event.currentTarget;
	var old : String = text;
	//on realise quelques modif pour rectifier un "probleme de placement" du curseur
	
	text = recherche.text;
	
	if (old.length > text.length)
	{
		text = old.substr(0, old.length - 1);
		
	}

	else
	{
	
	   text = old + text.charAt(0);
	}
	
	begin("",text);
}


private function addText(sValue:String, iColor:Int=0x000000,x:Int, y:Int) : TextField
	{
		//fonction cratrice d'input qui prend en paramtetres un texte a afficher dedans , la couleur , et les positions x et y
		
		var oTxtField:TextField = new TextField();
		oTxtField.width = 430;
		oTxtField.height = 60; 
		oTxtField.x = x;
		oTxtField.y = y;
		oTxtField.background = false;
		oTxtField.backgroundColor = 0xffffff;
		oTxtField.wordWrap = true;
		
		oTxtField.border = true;
		oTxtField.borderColor = 0x6C7BB8;
		oTxtField.selectable = true;
		oTxtField.type = TextFieldType.INPUT;//on le definit comme type imput
		
		
		
		var oTextFormat:TextFormat = new TextFormat();//parametres d'affichage
		oTextFormat.font = "Arial";
		oTextFormat.size = 40;
		oTextFormat.color = iColor;
		oTxtField.defaultTextFormat = oTextFormat;
 
		oTxtField.text = sValue;// assigne le texte à afficher

		return oTxtField;	  
	}

	
	
	private function initialize ():Void {
		
		//fonction qui initialise les parametres de la fonction begin et du placement general des elements de l'application
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		text = "";
	
		
		
	}
	private function DownHappened(downEvent:MouseEvent):Void
	{
		//fonction faisant suite a un evenement (ici quand on ajoute un contact)
		var TextRetruned : String = "";
		var  num =  0;
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 24, 0xff0000);
	
	
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); //connexion a la base
		if (debugNom.length>0 && debugNumero.length>0) //si l'utilisateur a rentré des valeurs dans les champs
		{
		connection.request("INSERT INTO Contact (name,number) VALUES ('" + debugNom + "','" + debugNumero + "')"); //on enregistre
		TextRetruned = "Le contact "+debugNom+" a été ajouté"; //on lui dit
		}
		
		connection.close();

		begin(TextRetruned,""); // on retourne a la page d'accueil
		
		
	}
	private function DownHappenedModif(downEvent:MouseEvent):Void
	{
		
		
		//fonction qui modifie les données d'un contact faisant suite a un evenement (ici le clik sur le boutton modifier)
		
		var TextRetruned : String = "";
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 10, 0x6C7BB8);
	
		
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
	
		if (debugNumero.length <1 && debugNom.length>0) // si il a modifié juste de nom
		{
		connection.request("update Contact set name='"+debugNom+"' where id="+Id+"");
		TextRetruned = "Le contact "+nomMain+" a été modifié ";
		}
		if (debugNom.length < 1 && debugNumero.length>0) // si il a modifié juste de numero
		{
		connection.request("update Contact set number='"+debugNumero+"' where id="+Id+"");
		TextRetruned = "Le contact "+nomMain+" a été modifié ";
		}
		if(debugNom.length>0 && debugNumero.length > 0) // si il a modifié les 2 
		{
		connection.request("update Contact set name='"+debugNom+"' ,number='"+debugNumero+"' where id="+Id+"");
		TextRetruned = "Le contact "+nomMain+" a été modifié ";
			
		}
		debugNom = ""; // on réinitialise les champs en vue de la prochaine modif eventuelle
		debugNumero = "";
		connection.close();

		begin(TextRetruned,"");//on revient a la page d'accueil
		
		
	}
	private function DownHappenedReturnMain(downEvent:MouseEvent):Void
	{
		begin("", "");
		//(ré)affiche la page d'accueil
	}
	private function DownHappenedOption(downEvent:MouseEvent):Void
	{
		//si l'utilisateur veut aller dans les options
		
		ClearScreen();//on initialize l'ecran
		CreateBande(3, 1, 0);// on crée la bande menu adéquate
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 36, 0x999999);
		
		
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
		var rset = connection.request("SELECT count(*) FROM Contact");//calcul du nombre de contact total
		var nbContact = rset.getIntResult(0);
		if (nbContact > 0)//si il ya au moins 1 contact
		{
			var req = connection.request("SELECT name FROM contact WHERE id in (select min(id) from contact);"); // on definit le + ancien
			var firstContact =  req.getResult(0);
			var req2 = connection.request("SELECT name FROM contact WHERE id in( select max(id) from contact);"); // et le plus récent
			var LastContact =  req2.getResult(0);
			
				format = new TextFormat (font.fontName, 26, 0x999999);
			var TextFirstConact = new TextField();
				TextFirstConact.defaultTextFormat = format;
				TextFirstConact.width = 500;
				TextFirstConact.selectable = false;
				TextFirstConact.height = 70;
				TextFirstConact.x =30;
				TextFirstConact.y =  170;
				TextFirstConact.text = "Contact le plus ancien : " + Std.string(firstContact); // on affiche le + ancien
				addChild(TextFirstConact);
				
			var TextLastConact = new TextField();
				TextLastConact.defaultTextFormat = format;
				TextLastConact.width = 500;
				TextLastConact.selectable = false;
				TextLastConact.height = 70;
				TextLastConact.x =30;
				TextLastConact.y =  250;
				TextLastConact.text = "Contact le plus récent : "+Std.string(LastContact); // et le plus récent
				addChild(TextLastConact);
		}
		connection.close();
		format = new TextFormat (font.fontName, 36, 0x999999);
		var TextNbContact = new TextField();
				TextNbContact.defaultTextFormat = format;
				TextNbContact.width = 500;
				TextNbContact.selectable = false;
				TextNbContact.height = 70;
				TextNbContact.x =30;
				TextNbContact.y =  100;
				TextNbContact.text = "Vous avez " + Std.string(nbContact) + " contact(s)"; // affichage du nombre total de contacts
				addChild(TextNbContact);
			
		
				
		
		format = new TextFormat (font.fontName, 26, 0x999999);
		var AstuceText = new TextField();
				AstuceText.defaultTextFormat = format;
				AstuceText.width = 500;
				AstuceText.selectable = false;
				AstuceText.height = 340;
				AstuceText.x =30;
				AstuceText.y =  350;
				AstuceText.text = "Astuce : pour modifier ou \r\nsupprimer un contact allez \r\ndans Accueil et selectionnez \r\nle contact a éditer a l'aide \r\n du ' + '";
				addChild(AstuceText);
		
		
		ButtonAllSuprr = new ButtonTrial(420.0, 100.0,0x888888);

		
		ButtonAllSuprr.x = cast(Lib.current.stage.stageWidth, Float)/2;
		ButtonAllSuprr.y = 700;
		this.addChild(ButtonAllSuprr);
		ButtonAllSuprr.MouseDown = DownHappenedGoAllSuprr;// bouton qui permet la suppression de tout les contact ! Attention :)
		
		format = new TextFormat (font.fontName, 28, 0x000000);
		var TextButtonAllSupprs = new TextField();
				TextButtonAllSupprs.defaultTextFormat = format;
				TextButtonAllSupprs.width = 500;
				TextButtonAllSupprs.selectable = false;
				TextButtonAllSupprs.height = 70;
				TextButtonAllSupprs.x = cast(Lib.current.stage.stageWidth, Float)/2-(420/2)+20;
				TextButtonAllSupprs.y =  685;
				TextButtonAllSupprs.text = "Supprimer tout les contact"; // texte assigné au bouton
				TextButtonAllSupprs.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedGoAllSuprr); //evenement assigné au texte également
				addChild(TextButtonAllSupprs);
		
	}
	private function DownHappenedGoAllSuprr(downEvent:MouseEvent):Void
	{
		//fonction appellé suite a un evnement provoqué dans la fonction du dessus
		//fonction qui supprime tout les contact en supprimant la table (elle sera recrée dans la fonction begin() ) , on réinitialise ainsi les id des contacts
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
		
		var drop = connection.request("Drop table contact");
		connection.close();
		begin("Tout les contacts on été supprimés","");
	}
	private function DownHappenedGoSuprr(downEvent:MouseEvent):Void
	{
		
		//fonction qui supprime un contact en fontion de son Id
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
		
		var req = connection.request("Select name from contact where id=" + Id);//on recupere son nom 
		var nom = req.getResult(0);
		
		var rset = connection.request("Delete FROM Contact where id="+Id); // on supprime
		
		connection.close();
		begin("Le contact "+nom+" a ete supprimé",""); // on affiche le bon déreoulement de l'opération
	}
	private function DownHappenedSelected(downEvent:MouseEvent):Void
	{
		//fonction qui fait suite au clic sur le bouton editer un contact (+) de la page d'accueil
		var Idstring = downEvent.currentTarget.name; // on recupere l'id du contact qui correspond on nom de l'element cliqué
		
		ClearScreen();//initialisation de l'ecran
		CreateBande(3, 1, 2);//appel de la bande menu 
		Id = Std.parseInt(Idstring);// on convertit l'id string en id int
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 28, 0x777777);
		
		
		var TitreEditPage = new TextField(); // du texte 
				TitreEditPage.defaultTextFormat = format;
				TitreEditPage.width = 700;
				TitreEditPage.selectable = false;
				TitreEditPage.height = 150;
				TitreEditPage.x = 15;
				TitreEditPage.y =  80;
				TitreEditPage.text = "Modifier / Supprimer un contact";
				TitreEditPage.wordWrap; 
				addChild(TitreEditPage);
		
		var connection = Sqlite.open(nme.filesystem.File.applicationStorageDirectory.nativePath + "/Contacts.db"); 
		var rset = connection.request("SELECT * FROM Contact where id="+Id+"");
		for ( row in rset ) {
			
			// on affiche les information du contact voulu
			var format = new TextFormat (font.fontName, 40, 0xffffff);
		
			var textNom = new TextField();
			textNom.defaultTextFormat = format;
			textNom.width = cast(Lib.current.stage.stageWidth , Float);
			textNom.height = 50;
			textNom.x = 50;
			textNom.y = 140;
			textNom.text = "Nom : ";
			addChild(textNom);
			
			var nom:TextField; // on affiche le nom dans un imput de sorte a ce que l'on puisse le voi et le modifier directement 
			nom = this.addText(row.name, 0x6C7BB8, 50, 200);
			nomMain = row.name;
			nom.addEventListener (Event.CHANGE, Name_onChange);
			this.addChild(nom);	
			
			//de meme pour le numero
			var textNumero = new TextField();
			textNumero.defaultTextFormat = format;
			textNumero.width = cast(Lib.current.stage.stageWidth , Float);
			textNumero.height = 50;
			textNumero.x = 50;
			textNumero.y = 280;
			textNumero.text = "Numero : ";
			addChild(textNumero);
			
			
			var numero:TextField;
			numero = this.addText(row.number, 0x6C7BB8,50,340);
			numero.addEventListener (Event.CHANGE, Number_onChange);
			this.addChild(numero);
		}
		
		
				ButtonModif = new ButtonTrial(420.0, 100.0, 0x888888);//boutton actionnant la modif
				ButtonModif.x = cast(Lib.current.stage.stageWidth, Float)/2;
				ButtonModif.y = 480;
				this.addChild(ButtonModif);
				ButtonModif.MouseDown = DownHappenedModif;
			
			format = new TextFormat (font.fontName, 40, 0x000000);//texte du boutton 
			var textButtonModif = new TextField();
				textButtonModif.defaultTextFormat = format;
				textButtonModif.width = 200;
				textButtonModif.selectable = false;
				textButtonModif.height = 70;
				textButtonModif.x = cast(Lib.current.stage.stageWidth, Float)/2-120;
				textButtonModif.y =  455;
				textButtonModif.text = "Modifier";
				textButtonModif.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedModif);
				addChild(textButtonModif);
			
			
			
			
		ButtonSuprr = new ButtonTrial(420.0, 100.0, 0x888888); //boutton actionnant la suppression

		
		ButtonSuprr.x = cast(Lib.current.stage.stageWidth, Float)/2;
		ButtonSuprr.y = 600;
		this.addChild(ButtonSuprr);
		ButtonSuprr.MouseDown = DownHappenedGoSuprr;
		
		
		var textButtonSuppr = new TextField(); //texte du boutton 
				textButtonSuppr.defaultTextFormat = format;
				textButtonSuppr.width = 220;
				textButtonSuppr.selectable = false;
				textButtonSuppr.height = 70;
				textButtonSuppr.x = cast(Lib.current.stage.stageWidth, Float)/2-120;
				textButtonSuppr.y = 575 ;
			textButtonSuppr.text = ("Supprimer");
			textButtonSuppr.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedGoSuprr);
			addChild(textButtonSuppr);
		
		ButtonBackmain = new ButtonTrial(420.0, 100.0, 0x888888); //boutton actionnant le retour a la page d'accueil
		ButtonBackmain.x = cast(Lib.current.stage.stageWidth, Float)/2;
		ButtonBackmain.y = 720;
		this.addChild(ButtonBackmain);
		ButtonBackmain.MouseDown = DownHappenedReturnMain;
		
			format = new TextFormat (font.fontName, 28, 0x00000); // texte du boutton 
			var textButtonBackmain = new TextField();
				textButtonBackmain.defaultTextFormat = format;
				textButtonBackmain.width = 400;
				textButtonBackmain.selectable = false;
				textButtonBackmain.height = 70;
				textButtonBackmain.x = cast(Lib.current.stage.stageWidth, Float)/2-200;
				textButtonBackmain.y = 700 ;
			textButtonBackmain.text = ("Retour a la liste de Contact");
			textButtonBackmain.addEventListener(MouseEvent.MOUSE_DOWN , DownHappenedReturnMain);
			addChild(textButtonBackmain);
	
	}

	
	private function DownHappenedGoAjout(downEvent:MouseEvent):Void
	{
		//fonction faisant suite au un clic sur "Ajouter" 
		ClearScreen();
		CreateBande(3,2,0);
		var  num =  0;
		var font = Assets.getFont ("assets/VeraSe.ttf");
		var format = new TextFormat (font.fontName, 40, 0x676767);
		
		
		
	
		var textAjout = new TextField(); //encore du texte
				textAjout.defaultTextFormat = format;
				textAjout.width = cast(Lib.current.stage.stageWidth , Float);
				textAjout.height = 50;
				textAjout.x = 50;
				textAjout.y = 65;
			textAjout.text = "Ajouter un Contact";
		addChild(textAjout);
		
		var format = new TextFormat (font.fontName, 40, 0xffffff);
		
		var textNom = new TextField();
				textNom.defaultTextFormat = format;
				textNom.width = cast(Lib.current.stage.stageWidth , Float);
				textNom.height = 50;
				textNom.x = 50;
				textNom.y = 180;
			textNom.text = "Nom : ";
		addChild(textNom);
		
			var nom:TextField; // imput qui recoit le nom , et qui s'actualise grace a la fonction NameOnChange
			
		nom = this.addText("", 0x6C7BB8,50,240);
		nom.addEventListener (Event.CHANGE, Name_onChange);
		this.addChild(nom);
		
		var textNumero = new TextField();
				textNumero.defaultTextFormat = format;
				textNumero.width = cast(Lib.current.stage.stageWidth , Float);
				textNumero.height = 50;
				textNumero.x = 50;
				textNumero.y = 320;
			textNumero.text = "Numero : ";
		addChild(textNumero);
		
		var numero:TextField;  // imput qui recoit le numero , et qui s'actualise grace a la fonction NameOnChange
		numero = this.addText("", 0x6C7BB8,50,380);
		numero.addEventListener (Event.CHANGE, Number_onChange);
		this.addChild(numero);
		
		
		_freshButton = new ButtonTrial(420.0, 100.0,0x888888);

		
		_freshButton.x = cast(Lib.current.stage.stageWidth, Float)/2; //boutton ajouter 
		_freshButton.y = 620;
		this.addChild(_freshButton);
		_freshButton.MouseDown = DownHappened;
		
		var format = new TextFormat (font.fontName, 50, 0x000000); // texte du boutton
		
			var textButton = new TextField();
				textButton.defaultTextFormat = format;
				textButton.width = 250;
				textButton.height = 80;
				textButton.selectable = false;
				textButton.background = false;
				textButton.autoSize;
				textButton.x = cast(Lib.current.stage.stageWidth, Float)/2-110;
				textButton.y = 585;
				textButton.addEventListener(MouseEvent.MOUSE_DOWN , DownHappened); // au clis sur le bouton , on appele la fontion DownHappened
			textButton.text = "Ajouter";
	addChild(textButton);
		
		
		
	
	}

	
private function ClearScreen():Void {
		//fonction qui réinitailise l'ecran (ecran vide)
		var i:Int = 0;
		while (i < numChildren )
		{
			removeChildAt(i);
			i = 0; 
		}
	}
		
	
	
	public static function main () {
		
		//fonction main de la classe Contact, qui appelle la fonction new
		Lib.current.addChild (new Contacts ());
		
		
	}
	
	
}
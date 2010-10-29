package

{
	import com.godstroke.flixel.GsFlxButton;
	import com.godstroke.flixel.StarField;
	
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import levels.*;
	
	import org.flixel.*;
		
	public class PlayState extends FlxState

	{
		[Embed(source="../gfx/lvl_button_idle.png")] protected var gfx_idle:Class;
		[Embed(source = "../gfx/lvl_button.png")] protected var gfx_over:Class;
		
		private var levelButtonsVector:Vector.<GsFlxButton>;
		private var gr_levelButtons:FlxGroup = new FlxGroup();
		private var sf:StarField = new StarField();
		
		private var levelFlow:XML = <flow>
			<levels>

				<level>
					<name>First Assignment</name>
					<stateName>levels.FirstAssignment</stateName>
					<definition></definition>
				</level>
				
			
			</levels>
		</flow>
		
		override public function create():void
		{
			forceCompileLevels();
			
			var v_padding:int = 8;
			var h_padding:int = 12;
			var btn_width:int = 110;
			var btn_height:int = 14;
			var columns:int = 3;
			
			var i_y:int = 0;
			var i_x:int = 0;
			
			var i_y_max:int = 0;
			var i_x_max:int = 0;
			
			var i:int = 0;
			var l:uint = levelFlow.levels.level.length();
			
			var AllButtonsBoxScale:Rectangle = new Rectangle();
			
			
			add(sf);
			
			FlxG.mouse.show();
			
			levelButtonsVector = new Vector.<GsFlxButton>(l,true);
			
			for (; i<l ; i++){
				
				var levelData:XML = levelFlow.levels.level[i];
				
				var _x:int = i_x*(h_padding+btn_width);
				var _y:int = i_y*(v_padding+btn_height);
				
				
				AllButtonsBoxScale.height = (l-1)*btn_width;
				
				var params:Object = {classNameString:String(levelData.stateName)};
				var btn:GsFlxButton = new GsFlxButton(_x,_y,onLevelAccessBtn);
				btn.width = btn_width;
				btn.height = btn_height;
				btn.callbackParams = params;
				
				var txt_idle:FlxText = new FlxText(3,0,btn_width,String(levelData.name));
				txt_idle.alignment = "left";
				txt_idle.color = 0x0090ff;
				 
				var txt:FlxText = new FlxText(3,0,btn_width,String(levelData.name));
				txt.alignment = "left";
				txt.color = 0xFF0000;
				
				
				btn.loadText(txt_idle,txt);
				var i_over:FlxSprite = new FlxSprite(0,0,gfx_over);
				var i_idle:FlxSprite = new FlxSprite(0,0,gfx_idle);
				btn.loadGraphic(i_idle,i_over);
				
				gr_levelButtons.add(btn);
				
				
				
				// padding stuff
				
				i_y_max = i_y > i_y_max ? i_y : i_y_max;
				i_x_max = i_y > i_x_max ? i_y : i_x_max;
				
				if(i_x<columns-1){
					i_x++;
				}else{
					i_x = 0;
					i_y ++;
				}
				
				levelButtonsVector[i] = btn;
				
			}
			
			AllButtonsBoxScale.width = (i_x_max+1)*(btn_width) + (i_x_max)*(h_padding);
			AllButtonsBoxScale.height = (i_y_max+1)*(btn_height) + (i_y_max)*(v_padding);
			
			AllButtonsBoxScale.x = FlxG.width/2 - AllButtonsBoxScale.width/2;
			AllButtonsBoxScale.y = FlxG.height/2 - AllButtonsBoxScale.height/2;
			
			
			gr_levelButtons.x = AllButtonsBoxScale.x;
			gr_levelButtons.y = AllButtonsBoxScale.y;
			add(gr_levelButtons);
		}
		
		private function onLevelAccessBtn(params:Object):void{
			
			// resolve class
			var levelClassNameString:String = params.classNameString as String;
			//trace(levelClassNameString);
			var levelClass:Class = getDefinitionByName(levelClassNameString) as Class;
			FlxG.state = new levelClass();
		}
		
		private function forceCompileLevels():void{
			// include all level classes here
			var fa:FirstAssignment;
		}
	}

	

}


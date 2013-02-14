package awaybuilder.view.mediators
{
	import awaybuilder.events.EditorStateChangeEvent;
	import awaybuilder.model.IEditorModel;
	import awaybuilder.utils.ZoomUtil;
	import awaybuilder.view.components.EditStatusBar;
	import awaybuilder.view.components.events.ToolBarZoomEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditStatusBarMediator extends Mediator
	{
		[Inject]
		public var statusBar:EditStatusBar;
		
		[Inject]
		public var editor:IEditorModel;
		
		override public function onRegister():void
		{	
			this.eventMap.mapListener(this.statusBar, ToolBarZoomEvent.ZOOM_IN, statusBar_zoomInHandler);
			this.eventMap.mapListener(this.statusBar, ToolBarZoomEvent.ZOOM_OUT, statusBar_zoomOutHandler);
			this.eventMap.mapListener(this.statusBar, ToolBarZoomEvent.ZOOM_TO, statusBar_zoomToHandler);
			
			this.eventMap.mapListener(this.eventDispatcher, EditorStateChangeEvent.ZOOM_CHANGE, eventDispatcher_zoomChangeHandler);
		}
		
		private function eventDispatcher_zoomChangeHandler(event:EditorStateChangeEvent):void
		{
			this.statusBar.zoom = this.editor.zoom;
		}
		
		private function statusBar_zoomToHandler(event:ToolBarZoomEvent):void
		{
			this.editor.zoom = event.zoomValue;
		}
		
		private function statusBar_zoomInHandler(event:ToolBarZoomEvent):void
		{
			this.statusBar.zoom = this.editor.zoom = ZoomUtil.getNextHighestZoomPreset(this.editor.zoom);
		}
		
		private function statusBar_zoomOutHandler(event:ToolBarZoomEvent):void
		{
			this.statusBar.zoom = this.editor.zoom = ZoomUtil.getNextLowestZoomPreset(this.editor.zoom);
		}
	}
}
package com.asfug.form 
{
	import com.asfug.events.FormAMFEvent;
	import com.asfug.events.FormEvent;
	import com.asfug.form.Form;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class FormAMF extends Form
	{
		private var _submitFunc:String;
		private var _nc:NetConnection;
		private var _res:Responder;
		
		public function FormAMF(gateway_url:String, submit_func:String)
		{
			super(gateway_url);
			
			_submitFunc = submit_func;
			
			_nc = new NetConnection();
			_nc.connect(gateway_url);
			_res = new Responder(onResult, onError);
		}
		
		
		private function onResult(e:Object):void
		{
			//trace(e);
			dispatchEvent(new FormAMFEvent(FormAMFEvent.FORM_SUBMITTED, false, false, '', e));
		}

		private function onError(e:Object):void
		{
			//trace("error: " + e.description);
			dispatchEvent(new FormAMFEvent(FormAMFEvent.FORM_ERROR, false, false, e.description, e));
		}

		
		override public function submit():void
		{
			if (validate())
			{
				trace(_formVars);
				var o:Object = { };
				for (var p in _formVars) 
				{
					o[p] = _formVars[p];
					trace(o[p]);
				}
				_nc.call(_submitFunc, _res, o);
			}
		}
		
	}

}
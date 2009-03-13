package org.meta_environment.rascal.interpreter.staticErrors;

import org.meta_environment.rascal.ast.AbstractAST;

public class UndeclaredModuleError extends StaticError {
	private static final long serialVersionUID = -3215674111118811111L;
	
	public UndeclaredModuleError(String module, AbstractAST node) {
		super("Undeclared module: " + module, node);
	}

}

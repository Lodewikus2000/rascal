package org.rascalmpl.library.experiments.Compiler.RVM.Interpreter.Instructions;

import org.rascalmpl.library.experiments.Compiler.RVM.Interpreter.CodeBlock;
import org.rascalmpl.library.experiments.Compiler.RVM.Interpreter.Generator;

public abstract class Instruction {
	
	protected Opcode opcode;
	protected CodeBlock codeblock;

	Instruction(CodeBlock cb, Opcode opc){
		this.opcode = opc;
		this.codeblock = cb;
	}
	
	public int pcIncrement() {
		return opcode.getPcIncrement();
	}
	
	public String toString(){
		return opcode.toString();
	}
	
	public void generate(Generator codeEmittor){
		 codeblock.addCode0(opcode.getOpcode());
	}
   
}

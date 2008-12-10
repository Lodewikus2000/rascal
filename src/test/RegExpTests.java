package test;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import org.eclipse.imp.pdb.facts.INode;
import org.eclipse.imp.pdb.facts.IValue;
import org.eclipse.imp.pdb.facts.impl.hash.ValueFactory;
import org.meta_environment.rascal.ast.ASTFactory;
import org.meta_environment.rascal.ast.Command;
import org.meta_environment.rascal.interpreter.Evaluator;
import org.meta_environment.rascal.parser.ASTBuilder;
import org.meta_environment.rascal.parser.Parser;
import org.meta_environment.uptr.Factory;

import junit.framework.TestCase;

public class RegExpTests extends TestCase {
	private Parser parser = Parser.getInstance();
	private ASTFactory factory = new ASTFactory();
    private ASTBuilder builder = new ASTBuilder(factory);
	private Evaluator evaluator = new Evaluator(ValueFactory.getInstance(), factory, new PrintWriter(System.err));

	
	private boolean runTest(String statement) throws IOException {
		INode tree = parser.parse(new ByteArrayInputStream(statement.getBytes()));
		evaluator.clean();

		if (tree.getTreeNodeType() ==  Factory.ParseTree_Summary) {
			System.err.println(tree);
			return false;
		} else {
			Command stat = builder.buildCommand(tree);
			IValue value = evaluator.eval(stat.getStatement());
			
			if (value == null || ! value.getType().isBoolType())
				return false;
			return value.equals(ValueFactory.getInstance().bool(true)) ? true : false;
		}
	}
	
	public void testMatch() throws IOException {
		assertTrue(runTest("/abc/ ~= \"abc\";"));
		assertFalse(runTest("/def/ ~= \"abc\";"));
		assertTrue(runTest("/def/ ~! \"abc\";"));
		assertTrue(runTest("/[a-z]+/ ~= \"abc\";"));
		assertTrue(runTest("/.*is.*/ ~= \"Rascal is marvelous\";"));
		assertTrue(runTest("/@.*@/ ~= \"@ abc @\";"));
		
		assertTrue(runTest("(/<x:[a-z]+>/ ~= \"abc\") && (x == \"abc\");"));
		assertTrue(runTest("(/if<tst:.*>then<th:.*>fi/ ~= \"if a > b then c fi\") " +
				           "&& (tst == \" a > b \") && (th == \" c \");"));

		assertTrue(runTest("(/<l:.*>[Rr][Aa][Ss][Cc][Aa][Ll]<r:.*>/ ~= \"RASCAL is marvelous\")" +
				            "&& (l == \"\") && (r == \" is marvelous\");"));

	}
}
